import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/ai_chat/presentation/manager/cubit/ai_recipe_chat_cubit.dart';
import 'package:super_market/features/ai_chat/presentation/view/widgets/chat_message_card.dart';

class AiRecipeChatView extends StatefulWidget {
  const AiRecipeChatView({super.key});

  static const String routeId = '/aiRecipeChatView';

  @override
  State<AiRecipeChatView> createState() => _AiRecipeChatViewState();
}

class _AiRecipeChatViewState extends State<AiRecipeChatView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Chef'),
        actions: [
          IconButton(
            tooltip: 'New Chat',
            onPressed: () => context.read<AiRecipeChatCubit>().startNewChat(),
            icon: const Icon(Icons.add_comment_outlined),
          ),
          IconButton(
            tooltip: 'History',
            onPressed: () => _openHistorySheet(context),
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<AiRecipeChatCubit, AiRecipeChatState>(
              builder: (context, state) {
                if (state is AiRecipeChatUpdated) {
                  if (state.messages.isEmpty) {
                    return const Center(
                      child: Text('Type the name of a dish or recipe, and Gemini will return the ingredients and preparation method.'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];

                      return ChatMessageCard(
                        message: message,
                        availableIngredients: state.availableIngredients,
                        missingIngredients: state.missingIngredients,
                        onAddToCart: () {
                          context.read<AiRecipeChatCubit>().addAvailableIngredientsToCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Available ingredients have been added to the cart')),
                          );
                        },
                      );
                    },
                  );
                }

                if (state is AiRecipeChatError) {
                  return Center(child: Text(state.errorMessage));
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          BlocBuilder<AiRecipeChatCubit, AiRecipeChatState>(
            builder: (context, state) {
              final isSending = state is AiRecipeChatUpdated ? state.isSending : false;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: 'Example: I want a recipe for macaroni béchamel',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: isSending
                            ? null
                            : () {
                                context.read<AiRecipeChatCubit>().sendQuestion(_controller.text);
                                _controller.clear();
                              },
                        icon: isSending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.send),
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _openHistorySheet(BuildContext context) {
    final state = context.read<AiRecipeChatCubit>().state;
    if (state is! AiRecipeChatUpdated) return;

    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: ListView.builder(
            itemCount: state.sessions.length,
            itemBuilder: (_, index) {
              final session = state.sessions[index];
              return ListTile(
                leading: const Icon(Icons.chat_bubble_outline),
                title: Text(session.title),
                subtitle: Text(session.createdAt.toString()),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.read<AiRecipeChatCubit>().switchToSession(session.id);
                },
              );
            },
          ),
        );
      },
    );
  }
}
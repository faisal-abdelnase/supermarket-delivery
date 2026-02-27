part of 'ai_recipe_chat_cubit.dart';

sealed class AiRecipeChatState {
  const AiRecipeChatState();
}

final class AiRecipeChatInitial extends AiRecipeChatState {}

final class AiRecipeChatUpdated extends AiRecipeChatState {
  final List<ChatSessionModel> sessions;
  final String currentSessionId;
  final List<ChatMessageModel> messages;
  final Map<String, ProductsModel> availableIngredients;
  final List<String> missingIngredients;
  final bool isSending;

  const AiRecipeChatUpdated({
    required this.sessions,
    required this.currentSessionId,
    required this.messages,
    required this.availableIngredients,
    required this.missingIngredients,
    required this.isSending,
  });
}

final class AiRecipeChatError extends AiRecipeChatState {
  final String errorMessage;

  const AiRecipeChatError({required this.errorMessage});
}
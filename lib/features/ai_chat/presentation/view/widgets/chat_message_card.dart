import 'package:flutter/material.dart';
import 'package:super_market/features/ai_chat/data/model/chat_message_model.dart';
import 'package:super_market/features/home/data/model/products_model.dart';

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({
    super.key,
    required this.message,
    required this.availableIngredients,
    required this.missingIngredients,
    required this.onAddToCart,
  });

  final ChatMessageModel message;
  final Map<String, ProductsModel> availableIngredients;
  final List<String> missingIngredients;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == 'user';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        width: MediaQuery.sizeOf(context).width * 0.9,
        decoration: BoxDecoration(
          color: isUser ? Colors.green.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.message),
            if (!isUser && message.recipeSuggestion != null) ...[
              const SizedBox(height: 12),
              Text(
                'Available/Missing Components',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 6),
              ...message.recipeSuggestion!.ingredients.map(
                (ingredient) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    availableIngredients.containsKey(ingredient)
                        ? '✅ $ingredient (Available)'
                        : '❌ $ingredient (unavailable)',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: availableIngredients.isEmpty ? null : onAddToCart,
                  icon: const Icon(Icons.add_shopping_cart),
                  label: Text(
                    availableIngredients.isEmpty
                        ? 'No ingredients are available for the add-on.'
                        : 'Add available ingredients to cart',
                  ),
                ),
              ),
              if (missingIngredients.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Ingredients not available: ${missingIngredients.join(', ')}',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
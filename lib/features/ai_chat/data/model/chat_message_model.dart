class ChatMessageModel {
  final String role;
  final String message;
  final RecipeSuggestionModel? recipeSuggestion;

  const ChatMessageModel({
    required this.role,
    required this.message,
    this.recipeSuggestion,
  });

  ChatMessageModel copyWith({
    String? role,
    String? message,
    RecipeSuggestionModel? recipeSuggestion,
  }) {
    return ChatMessageModel(
      role: role ?? this.role,
      message: message ?? this.message,
      recipeSuggestion: recipeSuggestion ?? this.recipeSuggestion,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'message': message,
      'recipeSuggestion': recipeSuggestion?.toJson(),
    };
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      role: json['role'] ?? '',
      message: json['message'] ?? '',
      recipeSuggestion: json['recipeSuggestion'] != null
          ? RecipeSuggestionModel.fromJson(
              Map<String, dynamic>.from(json['recipeSuggestion']),
            )
          : null,
    );
  }
}

class RecipeSuggestionModel {
  final String dishName;
  final List<String> ingredients;
  final List<String> preparationSteps;

  const RecipeSuggestionModel({
    required this.dishName,
    required this.ingredients,
    required this.preparationSteps,
  });

  Map<String, dynamic> toJson() {
    return {
      'dishName': dishName,
      'ingredients': ingredients,
      'preparationSteps': preparationSteps,
    };
  }

  factory RecipeSuggestionModel.fromJson(Map<String, dynamic> json) {
    return RecipeSuggestionModel(
      dishName: json['dishName'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      preparationSteps: List<String>.from(json['preparationSteps'] ?? []),
    );
  }
}
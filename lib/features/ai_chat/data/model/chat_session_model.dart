import 'package:super_market/features/ai_chat/data/model/chat_message_model.dart';

class ChatSessionModel {
  final String id;
  final String title;
  final DateTime createdAt;
  final List<ChatMessageModel> messages;

  const ChatSessionModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.messages,
  });

  ChatSessionModel copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    List<ChatMessageModel>? messages,
  }) {
    return ChatSessionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'messages': messages.map((e) => e.toJson()).toList(),
    };
  }

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    return ChatSessionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'New Chat',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      messages: (json['messages'] as List? ?? [])
          .map((e) => ChatMessageModel.fromJson(e))
          .toList(),
    );
  }
}
import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:super_market/core/constant.dart';
import 'package:super_market/core/manager/cubit/my_cart_cubit.dart';
import 'package:super_market/features/ai_chat/data/model/chat_message_model.dart';
import 'package:super_market/features/ai_chat/data/model/chat_session_model.dart';

import 'package:super_market/features/home/data/model/products_model.dart';
import 'package:super_market/features/home/presentation/manager/cubit/products_cubit.dart';

part 'ai_recipe_chat_state.dart';

class AiRecipeChatCubit extends Cubit<AiRecipeChatState> {
  AiRecipeChatCubit({required this.productsCubit, required this.cartCubit})
      : super(AiRecipeChatInitial()) {
    _loadConversationLog();
  }

  final ProductsCubit productsCubit;
  final MyCartCubit cartCubit;

  // FIX 1: Dio must send raw JSON string, not a Map, to avoid serialization issues.
  // We handle this by using jsonEncode manually when calling post().
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  final List<ChatSessionModel> _sessions = [];
  String _currentSessionId = '';

  final Map<String, ProductsModel> _availableIngredients = {};
  final List<String> _missingIngredients = [];

  List<ChatMessageModel> get _currentMessages {
    final session = _sessions.where((e) => e.id == _currentSessionId).firstOrNull;
    return session?.messages ?? [];
  }

  Future<void> startNewChat() async {
    final session = ChatSessionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'New Chat',
      createdAt: DateTime.now(),
      messages: const [],
    );

    _sessions.insert(0, session);
    _currentSessionId = session.id;
    _availableIngredients.clear();
    _missingIngredients.clear();
    await _persistConversationLog();
    _emitUpdated(isSending: false);
  }

  Future<void> switchToSession(String sessionId) async {
    _currentSessionId = sessionId;
    _availableIngredients.clear();
    _missingIngredients.clear();
    _emitUpdated(isSending: false);
  }

  Future<void> sendQuestion(String prompt) async {
    if (prompt.trim().isEmpty) return;

    if (_currentSessionId.isEmpty) {
      await startNewChat();
    }

    final messages = [
      ..._currentMessages,
      ChatMessageModel(role: 'user', message: prompt.trim()),
    ];
    _upsertCurrentMessages(messages);
    _emitUpdated(isSending: true);

    try {
      final response = await _getGeminiRecipeResponse(prompt.trim());

      _scanIngredients(response.ingredients);

      final assistantMessage = ChatMessageModel(
        role: 'assistant',
        message: '',
        recipeSuggestion: response,
      );

      _upsertCurrentMessages([..._currentMessages, assistantMessage]);
      _emitUpdated(isSending: true);

      await _typewriterAssistantResponse(_buildFormattedReply(response));

      await _persistConversationLog();
      _emitUpdated(isSending: false);
    } catch (e) {
      final fallback = ChatMessageModel(
        role: 'assistant',
        message:
            'Unable to get a response from Gemini right now.\nCheck your API Key and internet connection, then try again.\nError: $e',
      );
      _upsertCurrentMessages([..._currentMessages, fallback]);
      await _persistConversationLog();
      _emitUpdated(isSending: false);
    }
  }

  void addAvailableIngredientsToCart() {
    for (final product in _availableIngredients.values) {
      cartCubit.addProductToCart(product, 1);
    }
    _emitUpdated(isSending: false);
  }

  Future<void> _typewriterAssistantResponse(String fullText) async {
    for (int i = 1; i <= fullText.length; i++) {
      final current = fullText.substring(0, i);
      final list = [..._currentMessages];
      if (list.isEmpty || list.last.role != 'assistant') return;

      final updatedAssistant = list.last.copyWith(message: current);
      list[list.length - 1] = updatedAssistant;
      _upsertCurrentMessages(list);
      _emitUpdated(isSending: true);

      await Future<void>.delayed(const Duration(milliseconds: 12));
    }
  }

  String _buildFormattedReply(RecipeSuggestionModel recipe) {
    final ingredients =
        recipe.ingredients.map((e) => '• $e').join('\n');
    final steps = recipe.preparationSteps
        .asMap()
        .entries
        .map((e) => '${e.key + 1}) ${e.value}')
        .join('\n');

    return 'Recipe: ${recipe.dishName}\n\nthe ingredients:\n$ingredients\n\nPreparation method:\n$steps';
  }

  Future<RecipeSuggestionModel> _getGeminiRecipeResponse(String prompt) async {
    // FIX 2: Remove the hardcoded key check so your real key is never accidentally blocked.
    // Just check if it's empty.
    if (kGeminiApiKey.trim().isEmpty) {
      throw Exception('Please add Gemini API Key inside kGeminiApiKey in constant.dart');
    }

    // FIX 3: Do NOT use response_mime_type — it changes the response structure
    // and can cause empty text responses on some Gemini versions.
    // Instead, ask for JSON in the prompt and parse manually.
    const apiUrlBase =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

    final payload = {
      'contents': [
        {
          'parts': [
            {
              'text':
                  'You are a cooking assistant for a supermarket app. '
                  'Reply with JSON only, no extra text, no markdown, no backticks. '
                  'Use exactly this format: '
                  '{"dishName":"dish name","ingredients":["ingredient1","ingredient2"],"preparationSteps":["step1","step2"]}. '
                  'Always respond in English regardless of the question language. '
                  'Question: $prompt',
            }
          ]
        }
      ],
      // FIX 4: Removed response_mime_type — causes issues with text extraction
      'generationConfig': {
        'temperature': 0.7,
        'maxOutputTokens': 1024,
      },
    };

    // FIX 5: Explicitly encode to JSON string so Dio doesn't mishandle nested maps
    final response = await _dio.post(
      '$apiUrlBase?key=$kGeminiApiKey',
      data: jsonEncode(payload),
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
        // FIX 6: Let Dio throw on 4xx/5xx so we get proper DioException with details
        validateStatus: (status) => status != null && status == 200,
      ),
    );

    // FIX 7: Safe extraction of text with better null checks
    final candidates = response.data['candidates'];
    if (candidates == null || (candidates as List).isEmpty) {
      throw Exception('Gemini: no candidates returned. Full response: ${response.data}');
    }

    final parts = candidates[0]?['content']?['parts'];
    if (parts == null || (parts as List).isEmpty) {
      throw Exception('Gemini: no parts in candidate. Full response: ${response.data}');
    }

    final String text = (parts[0]?['text'] ?? '').toString();

    if (text.trim().isEmpty) {
      throw Exception('Gemini returned empty text. Full response: ${response.data}');
    }

    final parsed = _tryParseRecipeJson(text);
    return RecipeSuggestionModel.fromJson(parsed);
  }

  Map<String, dynamic> _tryParseRecipeJson(String raw) {
    // FIX 8: More aggressive cleaning of markdown fences and whitespace
    final normalized = raw
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .replaceAll('\n', ' ')
        .trim();

    try {
      return Map<String, dynamic>.from(jsonDecode(normalized));
    } catch (_) {
      final int start = normalized.indexOf('{');
      final int end = normalized.lastIndexOf('}');
      if (start != -1 && end != -1 && end > start) {
        final slice = normalized.substring(start, end + 1);
        try {
          return Map<String, dynamic>.from(jsonDecode(slice));
        } catch (e) {
          throw Exception('JSON parse failed. Cleaned text: "$normalized". Error: $e');
        }
      }
      throw Exception('No JSON object found in Gemini response: "$raw"');
    }
  }

  Future<void> _loadConversationLog() async {
    final Box box = Hive.box(kRecipeChatLogBox);
    final List<String> rawSessions =
        (box.get(kRecipeChatSessionsKey, defaultValue: <String>[]) as List)
            .cast<String>();

    _sessions
      ..clear()
      ..addAll(
        rawSessions
            .map((e) => ChatSessionModel.fromJson(jsonDecode(e)))
            .toList(),
      );

    _currentSessionId =
        box.get(kRecipeChatCurrentSessionKey, defaultValue: '') as String;

    if (_sessions.isEmpty) {
      await startNewChat();
      return;
    }

    if (_currentSessionId.isEmpty ||
        !_sessions.any((e) => e.id == _currentSessionId)) {
      _currentSessionId = _sessions.first.id;
    }

    _emitUpdated(isSending: false);
  }

  Future<void> _persistConversationLog() async {
    final Box box = Hive.box(kRecipeChatLogBox);
    await box.put(
      kRecipeChatSessionsKey,
      _sessions.map((e) => jsonEncode(e.toJson())).toList(),
    );
    await box.put(kRecipeChatCurrentSessionKey, _currentSessionId);
  }

  void _scanIngredients(List<String> ingredients) {
    _availableIngredients.clear();
    _missingIngredients.clear();

    final products = productsCubit.allProducts;

    for (final ingredient in ingredients) {
      final normalizedIngredient = ingredient.toLowerCase().trim();
      ProductsModel? matched;

      for (final product in products) {
        final name = product.name.toLowerCase().trim();
        final description = product.description.toLowerCase().trim();
        
        if (name.contains(normalizedIngredient) ||
            normalizedIngredient.contains(name) ||
            description.contains(normalizedIngredient) ||
            normalizedIngredient.contains(description)
            ) {
          matched = product;
          break;
        }
      }

      if (matched != null) {
        _availableIngredients[ingredient] = matched;
      } else {
        _missingIngredients.add(ingredient);
      }
    }
  }

  void _upsertCurrentMessages(List<ChatMessageModel> messages) {
    final i = _sessions.indexWhere((e) => e.id == _currentSessionId);
    if (i == -1) return;

    final current = _sessions[i];
    final title = messages.where((e) => e.role == 'user').isNotEmpty
        ? messages.firstWhere((e) => e.role == 'user').message
        : current.title;

    _sessions[i] = current.copyWith(
      messages: messages,
      title: title.length > 28 ? '${title.substring(0, 28)}...' : title,
    );
  }

  void _emitUpdated({required bool isSending}) {
    emit(
      AiRecipeChatUpdated(
        sessions: List.unmodifiable(_sessions),
        currentSessionId: _currentSessionId,
        messages: List.unmodifiable(_currentMessages),
        availableIngredients: Map.unmodifiable(_availableIngredients),
        missingIngredients: List.unmodifiable(_missingIngredients),
        isSending: isSending,
      ),
    );
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
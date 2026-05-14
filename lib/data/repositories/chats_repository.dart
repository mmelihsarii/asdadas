import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/errors/app_exception.dart';
import '../../core/errors/error_handler.dart';
import '../../core/services/supabase_service.dart';
import '../models/models.dart';

part 'chats_repository.g.dart';

@riverpod
ChatsRepository chatsRepository(ChatsRepositoryRef ref) {
  return ChatsRepository();
}

class ChatsRepository {
  final _supabase = SupabaseService.instance.client;

  /// Get my chats
  Future<List<Chat>> getMyChats() async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      // Get chat IDs where user is a member
      final memberResponse = await _supabase
          .from('chat_members')
          .select('chat_id')
          .eq('user_id', userId);

      final chatIds = (memberResponse as List)
          .map((m) => m['chat_id'] as String)
          .toList();

      if (chatIds.isEmpty) return [];

      // Get chats
      final response = await _supabase
          .from('chats')
          .select()
          .inFilter('id', chatIds)
          .order('created_at', ascending: false);

      return (response as List).map((json) => Chat.fromJson(json)).toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get my chats as a realtime stream
  Stream<List<Chat>> getMyChatsStream() {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    // Stream chats where user is a member
    // Note: This is a simplified version. For production, you might want to
    // join with chat_members table or use a database view
    return _supabase
        .from('chats')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map(
          (data) => (data as List).map((json) => Chat.fromJson(json)).toList(),
        );
  }

  /// Get messages for a chat
  Future<List<Message>> getMessages(
    String chatId, {
    int limit = 50,
    int offset = 0,
  }) async {
    final response = await _supabase
        .from('messages')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    return (response as List).map((json) => Message.fromJson(json)).toList();
  }

  /// Get last message for a chat
  Future<Message?> getLastMessage(String chatId) async {
    final response = await _supabase
        .from('messages')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();

    if (response == null) return null;
    return Message.fromJson(response);
  }

  /// Send a message
  Future<Message> sendMessage(String chatId, String body) async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    final response = await _supabase
        .from('messages')
        .insert({'chat_id': chatId, 'sender_id': userId, 'body': body})
        .select()
        .single();

    return Message.fromJson(response);
  }

  /// Get or create chat for a match
  Future<Chat> getOrCreateMatchChat(String matchId) async {
    // Check if chat exists
    final existing = await _supabase
        .from('chats')
        .select()
        .eq('match_id', matchId)
        .maybeSingle();

    if (existing != null) {
      return Chat.fromJson(existing);
    }

    // Create new chat
    final response = await _supabase
        .from('chats')
        .insert({'match_id': matchId})
        .select()
        .single();

    return Chat.fromJson(response);
  }

  /// Add user to chat
  Future<void> addMemberToChat(String chatId, String userId) async {
    await _supabase.from('chat_members').insert({
      'chat_id': chatId,
      'user_id': userId,
    });
  }

  /// Subscribe to new messages (Realtime)
  Stream<List<Message>> subscribeToMessages(String chatId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at', ascending: true)
        .map(
          (data) =>
              (data as List).map((json) => Message.fromJson(json)).toList(),
        );
  }

  /// Get chat members
  Future<List<ChatMember>> getChatMembers(String chatId) async {
    final response = await _supabase
        .from('chat_members')
        .select()
        .eq('chat_id', chatId);

    return (response as List).map((json) => ChatMember.fromJson(json)).toList();
  }
}

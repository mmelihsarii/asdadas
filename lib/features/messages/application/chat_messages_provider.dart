import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/chats_repository.dart';

part 'chat_messages_provider.g.dart';

/// Provider for chat messages (realtime stream)
@riverpod
Stream<List<Message>> chatMessages(ChatMessagesRef ref, String chatId) {
  final repo = ref.watch(chatsRepositoryProvider);
  return repo.subscribeToMessages(chatId);
}

/// Provider for sending a message
@riverpod
class SendMessage extends _$SendMessage {
  @override
  FutureOr<void> build() {}

  Future<void> send(String chatId, String body) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(chatsRepositoryProvider);
      await repo.sendMessage(chatId, body);

      // Invalidate messages to refresh
      ref.invalidate(chatMessagesProvider(chatId));
    });
  }
}

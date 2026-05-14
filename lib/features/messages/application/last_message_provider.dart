import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/message_model.dart';
import '../../../data/repositories/chats_repository.dart';

part 'last_message_provider.g.dart';

@riverpod
Future<Message?> lastMessage(LastMessageRef ref, String chatId) async {
  final repo = ref.watch(chatsRepositoryProvider);
  return repo.getLastMessage(chatId);
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/chats_repository.dart';

part 'my_chats_provider.g.dart';

/// Provider for current user's chats (realtime stream)
@riverpod
Stream<List<Chat>> myChats(MyChatsRef ref) {
  final chatsRepo = ref.watch(chatsRepositoryProvider);
  return chatsRepo.getMyChatsStream();
}

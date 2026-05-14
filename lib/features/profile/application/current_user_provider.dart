import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/users_repository.dart';

part 'current_user_provider.g.dart';

/// Provider for current authenticated user
@riverpod
Future<User?> currentUser(CurrentUserRef ref) async {
  final usersRepo = ref.watch(usersRepositoryProvider);
  return await usersRepo.getCurrentUser();
}

/// Provider for current user stats
@riverpod
Future<Map<String, dynamic>> currentUserStats(CurrentUserStatsRef ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return {};

  final usersRepo = ref.watch(usersRepositoryProvider);
  return await usersRepo.getUserStats(user.id);
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/users_repository.dart';

part 'user_profile_provider.g.dart';

/// Provider for viewing another user's profile
@riverpod
Future<User> userProfile(UserProfileRef ref, String userId) async {
  final usersRepo = ref.watch(usersRepositoryProvider);
  return await usersRepo.getUserById(userId);
}

/// Provider for user's profile details
@riverpod
Future<UserProfile?> userProfileDetails(
  UserProfileDetailsRef ref,
  String userId,
) async {
  final usersRepo = ref.watch(usersRepositoryProvider);
  return await usersRepo.getUserProfile(userId);
}

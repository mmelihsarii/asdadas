import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/participations_repository.dart';

part 'my_matches_provider.g.dart';

/// Provider for current user's match participations
@riverpod
Future<List<Participation>> myParticipations(MyParticipationsRef ref) async {
  final participationsRepo = ref.watch(participationsRepositoryProvider);
  return await participationsRepo.getMyParticipations();
}

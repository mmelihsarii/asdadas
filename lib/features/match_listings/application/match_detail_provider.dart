import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/match_listings_repository.dart';

part 'match_detail_provider.g.dart';

/// Provider for match listing detail
@riverpod
Future<MatchListing> matchDetail(MatchDetailRef ref, String matchId) async {
  final matchRepo = ref.watch(matchListingsRepositoryProvider);
  return await matchRepo.getOne(matchId);
}

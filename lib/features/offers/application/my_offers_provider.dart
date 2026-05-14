import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/offers_repository.dart';

part 'my_offers_provider.g.dart';

/// Provider for current user's offers (sent and received)
@riverpod
Future<Map<String, List<Offer>>> myOffers(MyOffersRef ref) async {
  final offersRepo = ref.watch(offersRepositoryProvider);
  return await offersRepo.getMyOffers();
}

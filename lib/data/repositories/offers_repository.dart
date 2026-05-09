import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../models/models.dart';

part 'offers_repository.g.dart';

@riverpod
OffersRepository offersRepository(OffersRepositoryRef ref) {
  return OffersRepository();
}

class OffersRepository {
  final _supabase = SupabaseService.instance.client;

  /// Create a new offer
  Future<Offer> create(Map<String, dynamic> data) async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    data['from_user_id'] = userId;

    final response = await _supabase
        .from('offers')
        .insert(data)
        .select()
        .single();

    return Offer.fromJson(response);
  }

  /// Get my offers (sent and received)
  Future<Map<String, List<Offer>>> getMyOffers() async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    // Get sent offers
    final sentResponse = await _supabase
        .from('offers')
        .select()
        .eq('from_user_id', userId)
        .order('created_at', ascending: false);

    final sent = (sentResponse as List)
        .map((json) => Offer.fromJson(json))
        .toList();

    // Get received offers
    final receivedResponse = await _supabase
        .from('offers')
        .select()
        .eq('to_user_id', userId)
        .order('created_at', ascending: false);

    final received = (receivedResponse as List)
        .map((json) => Offer.fromJson(json))
        .toList();

    return {
      'sent': sent,
      'received': received,
    };
  }

  /// Get offer by ID
  Future<Offer> getOne(String id) async {
    final response = await _supabase
        .from('offers')
        .select()
        .eq('id', id)
        .single();

    return Offer.fromJson(response);
  }

  /// Counter offer
  Future<Offer> counter(String id, int amount) async {
    final response = await _supabase
        .from('offers')
        .update({
          'amount': amount,
          'status': 'COUNTERED',
          'counter_count': _supabase.rpc('increment', params: {'x': 1}),
        })
        .eq('id', id)
        .select()
        .single();

    return Offer.fromJson(response);
  }

  /// Accept offer
  Future<void> accept(String id) async {
    final offer = await getOne(id);

    // Start transaction-like operation
    // 1. Update offer status
    await _supabase
        .from('offers')
        .update({'status': 'ACCEPTED'})
        .eq('id', id);

    // 2. Create participation if it's a match listing offer
    if (offer.matchListingId != null) {
      await _supabase.from('participations').insert({
        'match_id': offer.matchListingId,
        'player_id': offer.fromUserId,
        'agreed_amount': offer.amount,
        'status': 'ACCEPTED',
      });
    }
  }

  /// Reject offer
  Future<void> reject(String id) async {
    await _supabase
        .from('offers')
        .update({'status': 'REJECTED'})
        .eq('id', id);
  }

  /// Get offers for a match listing
  Future<List<Offer>> getOffersForMatch(String matchListingId) async {
    final response = await _supabase
        .from('offers')
        .select()
        .eq('match_listing_id', matchListingId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => Offer.fromJson(json))
        .toList();
  }

  /// Get offers for a player listing
  Future<List<Offer>> getOffersForPlayer(String playerListingId) async {
    final response = await _supabase
        .from('offers')
        .select()
        .eq('player_listing_id', playerListingId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => Offer.fromJson(json))
        .toList();
  }
}

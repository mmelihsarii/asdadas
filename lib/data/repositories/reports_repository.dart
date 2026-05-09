import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../models/models.dart';

part 'reports_repository.g.dart';

@riverpod
ReportsRepository reportsRepository(ReportsRepositoryRef ref) {
  return ReportsRepository();
}

class ReportsRepository {
  final _supabase = SupabaseService.instance.client;

  /// Create a report
  Future<Report> create(Map<String, dynamic> data) async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    data['reporter_id'] = userId;

    final response = await _supabase
        .from('reports')
        .insert(data)
        .select()
        .single();

    return Report.fromJson(response);
  }

  /// Get my reports
  Future<List<Report>> getMyReports() async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    final response = await _supabase
        .from('reports')
        .select()
        .eq('reporter_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => Report.fromJson(json))
        .toList();
  }

  /// Get all reports (admin only)
  Future<List<Report>> getAllReports({ReportStatus? status}) async {
    var query = _supabase.from('reports').select();

    if (status != null) {
      query = query.eq('status', status.name.toUpperCase());
    }

    final response = await query.order('created_at', ascending: false);

    return (response as List)
        .map((json) => Report.fromJson(json))
        .toList();
  }

  /// Update report status (admin only)
  Future<Report> updateStatus(String reportId, ReportStatus status) async {
    final response = await _supabase
        .from('reports')
        .update({'status': status.name.toUpperCase()})
        .eq('id', reportId)
        .select()
        .single();

    return Report.fromJson(response);
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../../core/errors/error_handler.dart';
import '../../core/errors/app_exception.dart';
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
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      data['reporter_id'] = userId;

      final response = await _supabase
          .from('reports')
          .insert(data)
          .select()
          .single();

      return Report.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get my reports
  Future<List<Report>> getMyReports() async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      final response = await _supabase
          .from('reports')
          .select()
          .eq('reporter_id', userId)
          .order('created_at', ascending: false);

      return (response as List).map((json) => Report.fromJson(json)).toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get all reports (admin only)
  Future<List<Report>> getAllReports({ReportStatus? status}) async {
    try {
      var query = _supabase.from('reports').select();

      if (status != null) {
        query = query.eq('status', status.name.toUpperCase());
      }

      final response = await query.order('created_at', ascending: false);

      return (response as List).map((json) => Report.fromJson(json)).toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Update report status (admin only)
  Future<Report> updateStatus(String reportId, ReportStatus status) async {
    try {
      final response = await _supabase
          .from('reports')
          .update({'status': status.name.toUpperCase()})
          .eq('id', reportId)
          .select()
          .single();

      return Report.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }
}

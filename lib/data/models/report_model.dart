import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class Report with _$Report {
  const factory Report({
    required String id,
    @JsonKey(name: 'reporter_id') required String reporterId,
    @JsonKey(name: 'target_user_id') String? targetUserId,
    @JsonKey(name: 'target_type') required String targetType,
    @JsonKey(name: 'target_id') required String targetId,
    required String reason,
    @Default(ReportStatus.pending) ReportStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) =>
      _$ReportFromJson(json);
}

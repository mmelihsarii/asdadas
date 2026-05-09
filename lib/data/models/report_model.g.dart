// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportImpl _$$ReportImplFromJson(Map<String, dynamic> json) => _$ReportImpl(
  id: json['id'] as String,
  reporterId: json['reporter_id'] as String,
  targetUserId: json['target_user_id'] as String?,
  targetType: json['target_type'] as String,
  targetId: json['target_id'] as String,
  reason: json['reason'] as String,
  status:
      $enumDecodeNullable(_$ReportStatusEnumMap, json['status']) ??
      ReportStatus.pending,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$ReportImplToJson(_$ReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reporter_id': instance.reporterId,
      'target_user_id': instance.targetUserId,
      'target_type': instance.targetType,
      'target_id': instance.targetId,
      'reason': instance.reason,
      'status': _$ReportStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$ReportStatusEnumMap = {
  ReportStatus.pending: 'PENDING',
  ReportStatus.reviewed: 'REVIEWED',
  ReportStatus.resolved: 'RESOLVED',
};

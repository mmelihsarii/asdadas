// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationImpl _$$AppNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$AppNotificationImpl(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
  message: json['message'] as String,
  isRead: json['is_read'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$AppNotificationImplToJson(
  _$AppNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'message': instance.message,
  'is_read': instance.isRead,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$NotificationTypeEnumMap = {
  NotificationType.invite: 'invite',
  NotificationType.application: 'application',
  NotificationType.rating: 'rating',
  NotificationType.system: 'system',
};

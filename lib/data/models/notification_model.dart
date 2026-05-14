import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum NotificationType {
  @JsonValue('invite')
  invite,
  @JsonValue('application')
  application,
  @JsonValue('rating')
  rating,
  @JsonValue('system')
  system,
}

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required NotificationType type,
    required String message,
    @JsonKey(name: 'is_read') required bool isRead,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}

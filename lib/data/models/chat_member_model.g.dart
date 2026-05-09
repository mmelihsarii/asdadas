// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMemberImpl _$$ChatMemberImplFromJson(Map<String, dynamic> json) =>
    _$ChatMemberImpl(
      id: json['id'] as String,
      chatId: json['chat_id'] as String,
      userId: json['user_id'] as String,
      joinedAt: DateTime.parse(json['joined_at'] as String),
    );

Map<String, dynamic> _$$ChatMemberImplToJson(_$ChatMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chatId,
      'user_id': instance.userId,
      'joined_at': instance.joinedAt.toIso8601String(),
    };

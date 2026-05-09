import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_member_model.freezed.dart';
part 'chat_member_model.g.dart';

@freezed
class ChatMember with _$ChatMember {
  const factory ChatMember({
    required String id,
    @JsonKey(name: 'chat_id') required String chatId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'joined_at') required DateTime joinedAt,
  }) = _ChatMember;

  factory ChatMember.fromJson(Map<String, dynamic> json) =>
      _$ChatMemberFromJson(json);
}

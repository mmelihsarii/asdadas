import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'participation_model.freezed.dart';
part 'participation_model.g.dart';

@freezed
class Participation with _$Participation {
  const factory Participation({
    required String id,
    @JsonKey(name: 'match_id') required String matchId,
    @JsonKey(name: 'player_id') required String playerId,
    @JsonKey(name: 'agreed_amount') required int agreedAmount,
    @Default(ParticipationStatus.accepted) ParticipationStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Participation;

  factory Participation.fromJson(Map<String, dynamic> json) =>
      _$ParticipationFromJson(json);
}

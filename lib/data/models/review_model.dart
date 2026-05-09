import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    @JsonKey(name: 'match_id') required String matchId,
    @JsonKey(name: 'reviewer_id') required String reviewerId,
    @JsonKey(name: 'reviewee_id') required String revieweeId,
    required int stars,
    @Default([]) List<String> tags,
    String? comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);
}

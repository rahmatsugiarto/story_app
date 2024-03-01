import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_data.freezed.dart';
part 'story_data.g.dart';

@freezed
class StoryData with _$StoryData {
  factory StoryData({
    String? id,
    String? name,
    String? description,
    String? photoUrl,
    String? createdAt,
    double? lat,
    double? lon,
  }) = _StoryData;

  factory StoryData.fromJson(Map<String, dynamic> json) =>
      _$StoryDataFromJson(json);
}

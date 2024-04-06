import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/models/response/story_data/story_data.dart';

part 'story_response.freezed.dart';
part 'story_response.g.dart';

@freezed
class StoryResponse with _$StoryResponse {
  factory StoryResponse({
    bool? error,
    String? message,
    List<StoryData>? listStory,
  }) = _StoryResponse;

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);
}

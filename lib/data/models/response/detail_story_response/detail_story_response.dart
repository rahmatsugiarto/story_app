import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/models/response/story_data/story_data.dart';


part 'detail_story_response.freezed.dart';
part 'detail_story_response.g.dart';

@freezed
class DetailStoryResponse with _$DetailStoryResponse {
  factory DetailStoryResponse({
    bool? error,
    String? message,
    StoryData? story,
  }) = _DetailStoryResponse;

  factory DetailStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryResponseFromJson(json);
}

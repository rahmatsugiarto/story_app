import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_story_response.freezed.dart';
part 'post_story_response.g.dart';

@freezed
class PostStoryResponse with _$PostStoryResponse {
  factory PostStoryResponse({
    bool? error,
    String? message,
  }) = _PostStoryResponse;

  factory PostStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$PostStoryResponseFromJson(json);
}

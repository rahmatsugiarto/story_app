import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_request.freezed.dart';
part 'story_request.g.dart';

@Freezed(toJson: true)
class StoryRequest with _$StoryRequest {
  factory StoryRequest({
    required int page,
    required int size,
    required int location,
  }) = _StoryRequest;
}

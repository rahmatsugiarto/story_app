import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/data/models/response/detail_story_response/detail_story_response.dart';

part 'detail_story_state.freezed.dart';

@freezed
class DetailStoryState with _$DetailStoryState {
  factory DetailStoryState({
    required ViewData<DetailStoryResponse> detailState,
  }) = _DetailStoryState;
}

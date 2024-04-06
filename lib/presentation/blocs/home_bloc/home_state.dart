import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/data/models/response/story_response/story_response.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required ViewData<StoryResponse> homeState,
    required int page,
  }) = _HomeState;
}

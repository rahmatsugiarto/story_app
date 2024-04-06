import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/data/models/response/post_story_response/post_story_response.dart';

part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  factory PostState({
    required ViewData<PostStoryResponse> postState,
    required bool isReadyToPost,
    required String address,
    LatLng? location,
  }) = _PostState;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/data/models/response/detail_story_response/detail_story_response.dart';

part 'detail_story_maps_state.freezed.dart';

@freezed
class DetailStoryMapsState with _$DetailStoryMapsState {
  factory DetailStoryMapsState({
    required ViewData<DetailStoryResponse> detailState,
    required Marker markers,
    required bool isShowMore,
  }) = _DetailStoryMapsState;
}

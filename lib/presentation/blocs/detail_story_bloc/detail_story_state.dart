import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/data/models/response/detail_story_response.dart';

class DetailStoryState {
  final ViewData<DetailStoryResponse> detailState;

  const DetailStoryState({
    required this.detailState,
  });

  DetailStoryState copyWith({
    ViewData<DetailStoryResponse>? detailState,
  }) {
    return DetailStoryState(
      detailState: detailState ?? this.detailState,
    );
  }
}

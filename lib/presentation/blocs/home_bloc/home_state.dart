import 'package:story_app/data/models/response/story_response.dart';

import '../../../core/state/view_data_state.dart';

class HomeState {
  final ViewData<StoryResponse> homeState;
  final int page;

  const HomeState({
    required this.homeState,
    required this.page,
  });

  HomeState copyWith({
    ViewData<StoryResponse>? homeState,
    int? page,
  }) {
    return HomeState(
      homeState: homeState ?? this.homeState,
      page: page ?? this.page,
    );
  }
}

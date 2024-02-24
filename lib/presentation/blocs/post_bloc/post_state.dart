import 'package:story_app/data/models/response/post_story_response.dart';

import '../../../core/state/view_data_state.dart';

class PostState {
  final ViewData<PostStoryResponse> postState;
  final bool isReadyToPost;

  const PostState({
    required this.postState,
    required this.isReadyToPost,
  });

  PostState copyWith({
    ViewData<PostStoryResponse>? postState,
    bool? isReadyToPost,
  }) {
    return PostState(
      postState: postState ?? this.postState,
      isReadyToPost: isReadyToPost ?? this.isReadyToPost,
    );
  }
}

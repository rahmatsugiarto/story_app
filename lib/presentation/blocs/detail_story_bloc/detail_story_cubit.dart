import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/state/view_data_state.dart';
import '../../../data/repositories/remote_repository.dart';
import 'detail_story_state.dart';

@LazySingleton()
class DetailStoryCubit extends Cubit<DetailStoryState> {
  final RemoteRepository remote;

  DetailStoryCubit({
    required this.remote,
  }) : super(DetailStoryState(
          detailState: ViewData.initial(),
        ));

  void fetchDetailStory({required String id}) async {
    emit(state.copyWith(detailState: ViewData.loading()));

    final result = await remote.fetchDetailStory(id: id);
    result.fold(
      (errorMsg) => emit(
        state.copyWith(
          detailState: ViewData.error(message: errorMsg),
        ),
      ),
      (result) => emit(
        state.copyWith(
          detailState: ViewData.loaded(data: result),
        ),
      ),
    );
  }
}

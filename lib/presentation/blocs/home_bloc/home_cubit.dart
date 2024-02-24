import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:story_app/data/repositories/local_repository.dart';

import '../../../core/state/view_data_state.dart';
import '../../../data/repositories/remote_repository.dart';
import 'home_state.dart';

@LazySingleton()
class HomeCubit extends Cubit<HomeState> {
  final RemoteRepository remote;
  final LocalRepository local;

  HomeCubit({
    required this.remote,
    required this.local,
  }) : super(HomeState(
          homeState: ViewData.initial(),
          page: 1,
        ));

  void fetchListStory({required int page}) async {
    emit(state.copyWith(homeState: ViewData.loading()));

    final result = await remote.fetchListStory(page: page);
    result.fold(
      (errorMsg) => emit(
        state.copyWith(
          homeState: ViewData.error(message: errorMsg),
          page: page,
        ),
      ),
      (result) => emit(
        state.copyWith(
          homeState: ViewData.loaded(data: result),
          page: page,
        ),
      ),
    );
  }

  void clearUserData() => local.clearUserData();
}

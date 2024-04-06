import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/local_repository.dart';
import 'splash_state.dart';

@LazySingleton()
class SplashCubit extends Cubit<SplashState> {
  final LocalRepository local;

  SplashCubit({
    required this.local,
  }) : super(SplashState(isLogin: false));

  void getToken() async {
    final isLogin = await local.getToken() != "";

    emit(state.copyWith(isLogin: isLogin));
  }
}

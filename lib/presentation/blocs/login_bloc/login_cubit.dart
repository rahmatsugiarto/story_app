import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/state/view_data_state.dart';
import '../../../data/repositories/local_repository.dart';
import '../../../data/repositories/remote_repository.dart';
import 'login_state.dart';

@LazySingleton()
class LoginCubit extends Cubit<LoginState> {
  final RemoteRepository remote;
  final LocalRepository local;

  LoginCubit({
    required this.remote,
    required this.local,
  }) : super(LoginState(
          loginState: ViewData.initial(),
        ));

  void authLogin({required String email, required String pass}) async {
    emit(state.copyWith(loginState: ViewData.loading()));

    final result = await remote.authLogin(email: email, pass: pass);

    result.fold(
      (message) {
        emit(state.copyWith(loginState: ViewData.error(message: message)));
      },
      (result) async {
        await local.saveUserData(
          token: result.loginResult?.token,
          userId: result.loginResult?.userId,
        );

        emit(state.copyWith(loginState: ViewData.loaded()));
      },
    );
  }
}

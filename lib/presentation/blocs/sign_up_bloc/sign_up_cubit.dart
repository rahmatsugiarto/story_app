import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/state/view_data_state.dart';
import '../../../data/repositories/remote_repository.dart';
import 'sign_up_state.dart';

@LazySingleton()
class SignUpCubit extends Cubit<SignUpState> {
  final RemoteRepository remote;

  SignUpCubit({
    required this.remote,
  }) : super(SignUpState(
          signUpState: ViewData.initial(),
        ));

  void authSignUp({
    required String name,
    required String email,
    required String pass,
  }) async {
    emit(state.copyWith(signUpState: ViewData.loading()));

    final result = await remote.authSignUp(
      name: name,
      email: email,
      pass: pass,
    );

    result.fold(
      (message) {
        emit(state.copyWith(signUpState: ViewData.error(message: message)));
      },
      (result) async {
        emit(state.copyWith(signUpState: ViewData.loaded()));
      },
    );
  }
}

import 'package:story_app/data/models/response/sign_up_response.dart';

import '../../../core/state/view_data_state.dart';

class SignUpState {
  final ViewData<SignUpResponse> signUpState;

  const SignUpState({
    required this.signUpState,
  });

  SignUpState copyWith({
    ViewData<SignUpResponse>? signUpState,
  }) {
    return SignUpState(
      signUpState: signUpState ?? this.signUpState,
    );
  }
}

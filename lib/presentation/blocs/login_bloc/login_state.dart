import 'package:story_app/data/models/response/login_response.dart';

import '../../../core/state/view_data_state.dart';

class LoginState {
  final ViewData<LoginResponse> loginState;

  const LoginState({
    required this.loginState,
  });

  LoginState copyWith({
    ViewData<LoginResponse>? loginState,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
    );
  }
}

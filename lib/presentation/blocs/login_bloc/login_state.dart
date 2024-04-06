import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/data/models/response/login_response/login_response.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    required ViewData<LoginResponse> loginState,
  }) = _LoginState;
}

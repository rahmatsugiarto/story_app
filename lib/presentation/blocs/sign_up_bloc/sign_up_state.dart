import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/data/models/response/sign_up_response/sign_up_response.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  factory SignUpState({
    required ViewData<SignUpResponse> signUpState,
  }) = _SignUpState;
}

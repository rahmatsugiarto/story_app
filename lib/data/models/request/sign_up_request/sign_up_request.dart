import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request.freezed.dart';
part 'sign_up_request.g.dart';

@Freezed(toJson: true)
class SignUpRequest with _$SignUpRequest {
  factory SignUpRequest({
    required String name,
    required String email,
    required String password,
  }) = _SignUpRequest;
}

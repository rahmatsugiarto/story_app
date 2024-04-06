import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

@Freezed(toJson: true)
class LoginRequest with _$LoginRequest {
  factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;
}

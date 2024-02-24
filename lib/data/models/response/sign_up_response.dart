class SignUpResponse {
  bool? error;
  String? message;

  SignUpResponse({this.error, this.message});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
  }
}

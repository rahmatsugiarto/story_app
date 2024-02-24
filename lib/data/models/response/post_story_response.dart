class PostStoryResponse {
  bool? error;
  String? message;

  PostStoryResponse({this.error, this.message});

  PostStoryResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
  }
}

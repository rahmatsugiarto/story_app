import 'package:story_app/data/models/response/story_data.dart';

class DetailStoryResponse {
  bool? error;
  String? message;
  StoryData? story;

  DetailStoryResponse({this.error, this.message, this.story});

  DetailStoryResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    story = json['story'] != null ? StoryData.fromJson(json['story']) : null;
  }
}

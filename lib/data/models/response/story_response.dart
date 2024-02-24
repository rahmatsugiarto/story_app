import 'package:story_app/data/models/response/story_data.dart';

class StoryResponse {
  bool? error;
  String? message;
  List<StoryData>? listStory;

  StoryResponse({this.error, this.message, this.listStory});

  StoryResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['listStory'] != null) {
      listStory = <StoryData>[];
      json['listStory'].forEach((v) {
        listStory!.add(StoryData.fromJson(v));
      });
    }
  }
}

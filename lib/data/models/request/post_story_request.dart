import 'package:dio/dio.dart';

class PostStoryRequest {
  MultipartFile photoFile;
  String description;
  double? lat;
  double? lon;

  PostStoryRequest({
    required this.photoFile,
    required this.description,
    this.lat,
    this.lon,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photo'] = photoFile;
    data['description'] = description;
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}

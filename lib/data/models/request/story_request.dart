class StoryRequest {
  int page;
  int size;
  int location;

  StoryRequest({
    required this.page,
    required this.size,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['size'] = size;
    data['location'] = location;
    return data;
  }
}

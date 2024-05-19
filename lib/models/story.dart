class Story {
  final int id;
  final String title;
  final String by;
  final int time;
  final String url;

  Story(
      {required this.id,
      required this.title,
      required this.by,
      required this.time,
      required this.url});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      title: json['title'],
      by: json['by'],
      time: json['time'],
      url: json['url'] ?? '',
    );
  }
}

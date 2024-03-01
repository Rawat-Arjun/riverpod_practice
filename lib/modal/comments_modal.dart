import 'dart:convert';

class Comments {
  final int userId;
  final int id;
  final String title;

  Comments({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Comments.fromMap(Map<String, dynamic> e) {
    return Comments(
      userId: e['userId'],
      id: e['id'],
      title: e['title'],
    );
  }

  factory Comments.fromJson(String source) =>
      Comments.fromMap(jsonDecode(source));
}

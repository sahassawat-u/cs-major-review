import 'package:cs_major_review/models/discussion_model.dart';

class Forum {
  final String topic;
  final String user;
  final String createdBy;
  final String comment;
  final String picture;
  final List<dynamic> tags;
  final List<dynamic> discussions;
  final String id;
  final int likes;

  Forum({
    required this.topic,
    required this.user,
    required this.picture,
    required this.createdBy,
    required this.comment,
    required this.discussions,
    required this.tags,
    required this.id,
    required this.likes,
  });
}

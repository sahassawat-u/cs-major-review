import 'package:cs_major_review/models/discussion_model.dart';

class Forum {
  final String topic;
  final String user;
  final String createdBy;
  final String comment;
  final int num;
  final List<dynamic> tags;
  final List<dynamic> discussions;

  Forum({
    required this.topic,
    required this.user,
    required this.createdBy,
    required this.comment,
    required this.num,
    required this.discussions,
    required this.tags,
  });
}

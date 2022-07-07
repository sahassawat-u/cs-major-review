import 'package:cs_major_review/models/comment_model.dart';

class University {
  final String uni;
  final double rating;
  final String topComment;
  final List<Comment> comments;

  University({
    required this.uni,
    required this.rating,
    required this.topComment,
    required this.comments,
  });
}

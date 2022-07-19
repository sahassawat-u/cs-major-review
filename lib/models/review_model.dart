import 'package:cs_major_review/models/comment_model.dart';

class Review {
  final String uni;
  final double rating;
  final double lat;
  final double long;
  final List<dynamic> comments;

  Review({
    required this.uni,
    required this.lat,
    required this.long,
    required this.rating,
    required this.comments,
  });
}

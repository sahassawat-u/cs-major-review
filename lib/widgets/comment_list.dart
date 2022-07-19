import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/models/comment_model.dart';
import 'package:cs_major_review/widgets/base_card.dart';
import 'package:cs_major_review/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentList extends StatelessWidget {
  final List<dynamic> comments;
  const CommentList({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 10,
      margin: EdgeInsets.symmetric(vertical: 10),
      // height:  MediaQuery.of(context).size.height,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: List.generate(
              comments.length,
              (index) => CommentCard(
                  rating: comments[index]['rating'],
                  title: comments[index]['title'],
                  comment: comments[index]['comment'],
                  picture: comments[index]['picture'] ?? profilePicture,
                  date: comments[index]['createdAt'],
                  reviewed_name: comments[index]['user']))),
    );
  }
}

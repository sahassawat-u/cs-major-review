import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/models/comment_model.dart';
import 'package:cs_major_review/widgets/base_card.dart';
import 'package:cs_major_review/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentList extends StatelessWidget {
  final List<Comment> comments;
  const CommentList({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 10,
      // height:  MediaQuery.of(context).size.height,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: List.generate(
              comments.length,
              (index) => CommentCard(
                  rating: comments[index].rating,
                  title: comments[index].title,
                  comment: comments[index].comment,
                  date: comments[index].createdDate,
                  reviewed_name: comments[index].user))
          // [
          //   CommentCard(
          //       rating: 2,
          //       title: "title",
          //       comment: "Lorem ipsum dolor sit amet, "
          //           "consectetur adipiscing elit, sed do"
          //           " eiusmod tempor incididunt ut labore "
          //           "et dolore magna aliqua. Ut enim ad minim "
          //           "veniam, quis nostrud exercitation ullamco"
          //           " laboris nisi ut aliquip ex ea commodo "
          //           "consequat. Duis aute irure dolor in "
          //           "reprehenderit in voluptate velit esse "
          //           "cillum dolore eu fugiat nulla pariatur. "
          //           "Excepteur sint occaecat cupidatat non proident, "
          //           "sunt in culpa qui officia deserunt mollit anim "
          //           "id est laborum.",
          //       date: "date",
          //       reviewed_name: "YU"),
          //   CommentCard(
          //       rating: 5,
          //       title: "title",
          //       comment: "Lorem ipsum dolor sit amet, "
          //           "consectetur adipiscing elit, sed do"
          //           " eiusmod tempor incididunt ut labore "
          //           "et dolore magna aliqua. Ut enim ad minim "
          //           "veniam, quis nostrud exercitation ullamco"
          //           " laboris nisi ut aliquip ex ea commodo "
          //           "consequat. Duis aute irure dolor in "
          //           "reprehenderit in voluptate velit esse "
          //           "cillum dolore eu fugiat nulla pariatur. "
          //           "Excepteur sint occaecat cupidatat non proident, "
          //           "sunt in culpa qui officia deserunt mollit anim "
          //           "id est laborum.",
          //       date: "date",
          //       reviewed_name: "YU"),
          //   CommentCard(
          //       rating: 5,
          //       title: "title",
          //       comment: "Lorem ipsum dolor sit amet, "
          //           "consectetur adipiscing elit, sed do"
          //           " eiusmod tempor incididunt ut labore "
          //           "et dolore magna aliqua. Ut enim ad minim "
          //           "veniam, quis nostrud exercitation ullamco"
          //           " laboris nisi ut aliquip ex ea commodo "
          //           "consequat. Duis aute irure dolor in "
          //           "reprehenderit in voluptate velit esse "
          //           "cillum dolore eu fugiat nulla pariatur. "
          //           "Excepteur sint occaecat cupidatat non proident, "
          //           "sunt in culpa qui officia deserunt mollit anim "
          //           "id est laborum.",
          //       date: "date",
          //       reviewed_name: "YU")
          // ],
          ),
    );
  }
}

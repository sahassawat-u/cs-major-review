import 'package:cs_major_review/models/forum_model.dart';
import 'package:cs_major_review/pages/discussion_page.dart';
import 'package:cs_major_review/widgets/tag.dart';
import 'package:flutter/material.dart';

class ForumBubble extends StatelessWidget {
  final Forum forum;
  const ForumBubble({Key? key, required this.forum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiscussonPage(forum: forum),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: 300,
          color: Colors.transparent,
          child: Column(children: [
            Container(
              width: double.infinity,
              child: Wrap(
                  children: List.generate(forum.tags.length, (index) {
                return Tag(
                  text: forum.tags[index],
                );
              })),
            ),
            Row(
              children: [
                Text(
                  forum.topic,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            Row(
              children: [
                Text("created By ", style: TextStyle(color: Color(0xffB2B9B9))),
                Text(forum.user)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(forum.num.toString() + " Discussions"),
                Text(forum.createdBy,
                    style: TextStyle(
                      color: Color(0xffB2B9B9),
                    ))
              ],
            ),
          ]),
        ));
  }
}

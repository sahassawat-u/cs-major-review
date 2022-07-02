import 'package:cs_major_review/pages/discussion_page.dart';
import 'package:cs_major_review/widgets/tag.dart';
import 'package:flutter/material.dart';

class ForumBubble extends StatelessWidget {
  const ForumBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiscussonPage(),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          height: 100,
          width: 300,
          color: Colors.transparent,
          child: Column(children: [
            Row(children: [Tag(text: "DSOOP"), Tag(text: "ALGO")]),
            Row(
              children: [
                Text("Let's talk about Algorithms",
                    style: TextStyle(fontSize: 18))
              ],
            ),
            Row(
              children: [
                Text("created By ", style: TextStyle(color: Color(0xffB2B9B9))),
                Text("Jaehyun")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("14 Discussions"),
                Text("Fri July 7 2022",
                    style: TextStyle(
                      color: Color(0xffB2B9B9),
                    ))
              ],
            ),
          ]),
        ));
  }
}

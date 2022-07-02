import 'package:cs_major_review/widgets/tag.dart';
import 'package:flutter/material.dart';

class Discussion extends StatelessWidget {
  const Discussion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print('Yo bro');
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          height: 100,
          width: 300,
          color: Colors.transparent,
          child: Column(children: [
            Row(children: [Tag(text: "DSOOP"), Tag(text: "ALGO")]),
            Row(
              children: [Text("Let's talk about Algorithms")],
            ),
            Row(
              children: [Text("created By Jaehyun")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("14 Discussions"), Text("Friday July 7 2022")],
            ),
          ]),
        ));
  }
}

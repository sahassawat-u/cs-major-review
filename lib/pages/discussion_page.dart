import 'package:cs_major_review/widgets/discussion_bubble.dart';
import 'package:cs_major_review/widgets/tag.dart';
import 'package:flutter/material.dart';

class DiscussonPage extends StatefulWidget {
  const DiscussonPage({Key? key}) : super(key: key);

  @override
  State<DiscussonPage> createState() => _DiscussonPageState();
}

class _DiscussonPageState extends State<DiscussonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(left: 40, right: 10),
      child: Column(children: [
        SizedBox(height: 50),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text("Back")
          ],
        ),
        SizedBox(height: 30),
        Column(children: [
          Row(
            children: [
              Text("Let's talk about Algorithms",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
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
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
                child: Text(
                    "We have good lecturers here, so it is fun and very useful, recommneded!",
                    style: TextStyle(
                      fontSize: 18,
                    )))
          ],
        ),
        SizedBox(height: 28),
        Row(
          children: [
            Tag(
              text: "DSOOP",
            ),
            Tag(
              text: "ALGO",
            )
          ],
        ),
        SizedBox(height: 20),
        Container(
            height: 400,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  DiscussBubble(),
                  DiscussBubble(),
                  DiscussBubble(),
                  DiscussBubble(),
                  DiscussBubble(),
                ],
              ),
            )),
        // Column(
        //   children: [DiscussBubble(), DiscussBubble()],
        // ),
      ]),
    ));
  }
}

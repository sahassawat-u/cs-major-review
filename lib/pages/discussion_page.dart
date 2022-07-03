import 'package:cs_major_review/models/forum_model.dart';
import 'package:cs_major_review/widgets/clickable_tag.dart';
import 'package:cs_major_review/widgets/discussion_bubble.dart';
import 'package:cs_major_review/widgets/tag.dart';
import 'package:flutter/material.dart';

class DiscussonPage extends StatefulWidget {
  final Forum forum;
  const DiscussonPage({Key? key, required this.forum}) : super(key: key);

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
              Text(widget.forum.topic,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
            ],
          ),
          Row(
            children: [
              Text("created By ", style: TextStyle(color: Color(0xffB2B9B9))),
              Text(widget.forum.user)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.forum.num.toString() + " Discussions"),
              Text(widget.forum.createdBy,
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
                child: Text(widget.forum.comment,
                    style: TextStyle(
                      fontSize: 18,
                    )))
          ],
        ),
        SizedBox(height: 28),
        Container(
          width: double.infinity,
          child: Wrap(
              children: List.generate(widget.forum.tags.length, (index) {
            return ClickableTag(
              isSelected: false,
              text: widget.forum.tags[index],
              onTap_: () {},
            );
          })),
        ),
        SizedBox(height: 20),
        Container(
            height: 400,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  children:
                      List.generate(widget.forum.discussions.length, (index) {
                return DiscussBubble(
                    discussion: widget.forum.discussions[index]);
              })
                  // [
                  //   DiscussBubble(),
                  //   DiscussBubble(),
                  //   DiscussBubble(),
                  //   DiscussBubble(),
                  //   DiscussBubble(),
                  // ],
                  ),
            )),
        // Column(
        //   children: [DiscussBubble(), DiscussBubble()],
        // ),
      ]),
    ));
  }
}

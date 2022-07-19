import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/models/forum_model.dart';
import 'package:cs_major_review/widgets/profile_picture.dart';
import 'package:cs_major_review/widgets/tag.dart';
import 'package:flutter/material.dart';

class ForumBubble extends StatefulWidget {
  final Forum forum;
  final VoidCallback onTap_;
  final bool showTag;
  const ForumBubble(
      {Key? key,
      required this.forum,
      required this.onTap_,
      required this.showTag})
      : super(key: key);

  @override
  State<ForumBubble> createState() => _ForumBubbleState();
}

class _ForumBubbleState extends State<ForumBubble> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap_,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: 300,
          color: Colors.transparent,
          child: Column(children: [
            widget.showTag
                ? Container(
                    width: double.infinity,
                    child: Wrap(
                        children:
                            List.generate(widget.forum.tags.length, (index) {
                      return Tag(
                        text: widget.forum.tags[index],
                      );
                    })),
                  )
                : SizedBox(),
            Row(
              children: [
                ProfilePicture(
                    picture: widget.forum.picture, width_: 40, height_: 40),
                SizedBox(
                  width: 15,
                ),
                Text(
                  widget.forum.topic,
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const Text("created By ",
                    style: TextStyle(color: kGreySubText)),
                Text(widget.forum.user)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.forum.discussions.length > 0
                    ? widget.forum.discussions.length.toString() +
                        " Discussions"
                    : "No discussion "),
                Text(widget.forum.createdBy,
                    style: TextStyle(
                      color: kGreySubText,
                    ))
              ],
            ),
          ]),
        ));
  }
}

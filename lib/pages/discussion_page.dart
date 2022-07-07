import 'package:cs_major_review/models/discussion_model.dart';
import 'package:cs_major_review/models/forum_model.dart';
import 'package:cs_major_review/widgets/clickable_tag.dart';
import 'package:cs_major_review/widgets/discussion_bubble.dart';
import 'package:cs_major_review/widgets/search.dart';
import 'package:cs_major_review/widgets/tag.dart';
import 'package:flutter/material.dart';

class DiscussonPage extends StatefulWidget {
  final Forum forum;
  const DiscussonPage({Key? key, required this.forum}) : super(key: key);

  @override
  State<DiscussonPage> createState() => _DiscussonPageState();
}

class _DiscussonPageState extends State<DiscussonPage> {
  String comment = "";
  bool isCommitComment = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 10),
        child: Column(
          children: [
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
                ],
              ),
              Row(
                children: [
                  Text("created By ",
                      style: TextStyle(color: Color(0xffB2B9B9))),
                  Text(widget.forum.user)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.forum.discussions.length > 0
                      ? widget.forum.discussions.length.toString() +
                          " Discussions"
                      : ""),
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
              height: 380,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children:
                        List.generate(widget.forum.discussions.length, (index) {
                  return DiscussBubble(
                      discussion: widget.forum.discussions[index]);
                })),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(30, 0, 30, 50),
          // color: Colors.red,
          child: Row(
            children: [
              Expanded(
                child: Search(
                    controller: controller,
                    isUsedIcon: false,
                    text: this.comment,
                    onChanged: (String comment) {
                      // print(isCommitComment);
                      // print(comment);
                      setState(() {
                        this.comment = comment;
                      });
                    },
                    hintText: "Share what your think..."),
              ),
              SizedBox(
                width: 8,
              ),
              TextButton(
                child: Text(
                  "Submit",
                  style: TextStyle(color: Color(0xff082D26)),
                ),
                onPressed: () {
                  controller.clear();
                  setState(() {
                    widget.forum.discussions.add(
                        Discussion(user: "Test User", comment: this.comment));
                    // isCommitComment = true;
                  });
                },
              ),
            ],
          )),
    );
  }
}

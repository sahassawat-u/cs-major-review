import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/models/forum_model.dart';
import 'package:cs_major_review/pages/discussion_page.dart';
import 'package:cs_major_review/widgets/tag.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForumBubble extends StatefulWidget {
  final Forum forum;
  final VoidCallback onTap_;
  const ForumBubble({Key? key, required this.forum, required this.onTap_})
      : super(key: key);

  @override
  State<ForumBubble> createState() => _ForumBubbleState();
}

class _ForumBubbleState extends State<ForumBubble> {
  // late List<dynamic> discussions;
  // late FirebaseFirestore _firestore;
  @override
  void initState() {
    super.initState();
    // initFirebase();
    // discussions = widget.forum.discussions;
  }

  // void initFirebase() async {
  //   await Firebase.initializeApp();
  //   _firestore = FirebaseFirestore.instance;
  //   // getDiscussions();
  // }

  // void getDiscussions() async {
  //   final data = await _firestore
  //       .collection('forums')
  //       .where('user', isEqualTo: widget.forum.user)
  //       .where('topic', isEqualTo: widget.forum.topic)
  //       .get();
  //   // print(test.docs[0].id)
  //   // if (test.docs.isNotEmpty) {
  //   print(data.docs[0].id);
  //   // }
  //   final discussions =
  //       await _firestore.collection('forums').doc(data.docs[0].id).get();
  //   // print(discussions.data());
  //   setState(() {
  //     this.discussions = discussions.data()!['discussions'];
  //   });
  // }

  // void initFirebaseAndFetchForums() async {
  //   await fire.initializeApp();
  //   _firestore = FirebaseFirestore.instance;
  //   getForums();
  // }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap_,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: 300,
          color: Colors.transparent,
          child: Column(children: [
            Container(
              width: double.infinity,
              child: Wrap(
                  children: List.generate(widget.forum.tags.length, (index) {
                return Tag(
                  text: widget.forum.tags[index],
                );
              })),
            ),
            Row(
              children: [
                Text(
                  widget.forum.topic,
                  style: TextStyle(fontSize: 18),
                )
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
                Text(widget.forum.discussions.length > 0
                    ? widget.forum.discussions.length.toString() +
                        " Discussions"
                    : "No discussion "),
                Text(widget.forum.createdBy,
                    style: TextStyle(
                      color: Color(0xffB2B9B9),
                    ))
              ],
            ),
          ]),
        ));
  }
}

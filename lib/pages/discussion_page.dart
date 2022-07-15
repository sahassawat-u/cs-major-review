import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/models/forum_model.dart';
import 'package:cs_major_review/widgets/clickable_tag.dart';
import 'package:cs_major_review/widgets/discussion_bubble.dart';
import 'package:cs_major_review/widgets/search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DiscussonPage extends StatefulWidget {
  final Forum forum;
  final List<dynamic> discussions;
  const DiscussonPage(
      {Key? key, required this.forum, required this.discussions})
      : super(key: key);

  @override
  State<DiscussonPage> createState() => _DiscussonPageState();
}

class _DiscussonPageState extends State<DiscussonPage> {
  String comment = "";
  bool isCommitComment = false;
  TextEditingController controller = TextEditingController();
  late FirebaseFirestore _firestore;
  late List<dynamic> discussions;
  @override
  void initState() {
    super.initState();
    initFirebase();
    discussions = widget.forum.discussions;
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  void getDiscussions() async {
    final data = await _firestore
        .collection('forums')
        .where('user', isEqualTo: widget.forum.user)
        .where('topic', isEqualTo: widget.forum.topic)
        .get();
    final discussions =
        await _firestore.collection('forums').doc(data.docs[0].id).get();
    setState(() {
      this.discussions = discussions.data()!['discussions'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
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
                  const Text("created By ",
                      style: TextStyle(color: kGreySubText)),
                  Text(widget.forum.user)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(discussions.length > 0
                      ? discussions.length.toString() + " Discussions"
                      : "No discussion"),
                  Text(widget.forum.createdBy,
                      style: TextStyle(
                        color: kGreySubText,
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
              // color: Colors.black,
              height: 350,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: List.generate(discussions.length, (index) {
                  return DiscussBubble(discussion: discussions[index]);
                })),
              ),
            ),
            Row(
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
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: kNavBarIcon),
                  ),
                  onPressed: () async {
                    controller.clear();
                    final data = await _firestore
                        .collection('forums')
                        .where('user', isEqualTo: widget.forum.user)
                        .where('topic', isEqualTo: widget.forum.topic)
                        .get();
                    // print(data.docs[0].id);
                    final discussions = await _firestore
                        .collection('forums')
                        .doc(data.docs[0].id)
                        .get();
                    var to_process_discussions =
                        discussions.data()!['discussions'];
                    Map<String, dynamic> discussion = {
                      'user': widget.forum.user,
                      'comment': comment
                    };
                    to_process_discussions.add(discussion);
                    setState(() {
                      this.discussions = to_process_discussions;
                    });
                    Map<String, dynamic> to_use_discussions = {
                      'discussions': to_process_discussions
                    };
                    _firestore
                        .collection('forums')
                        .doc(data.docs[0].id)
                        .set(to_use_discussions, SetOptions(merge: true));
                  },
                ),
              ],
            ),
          ],
          // ),
        ),
      ),
    );
  }
}

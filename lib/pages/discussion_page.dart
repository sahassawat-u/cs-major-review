import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/models/forum_model.dart';
import 'package:cs_major_review/providers/user_provider.dart';
import 'package:cs_major_review/widgets/clickable_tag.dart';
import 'package:cs_major_review/widgets/discussion_bubble.dart';
import 'package:cs_major_review/widgets/search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Like { UPVOTE, NEUTRAL, DOWNVOTE }

class DiscussonPage extends StatefulWidget {
  final Forum forum;
  // final List<dynamic> discussions;
  const DiscussonPage(
      // {Key? key, required this.forum, required this.discussions})
      {Key? key,
      required this.forum})
      : super(key: key);

  @override
  State<DiscussonPage> createState() => _DiscussonPageState();
}

class _DiscussonPageState extends State<DiscussonPage> {
  String comment = "";
  late Like which;
  bool isCommitComment = false;
  TextEditingController controller = TextEditingController();
  late FirebaseFirestore _firestore;
  late List<dynamic> discussions;
  late int likes;
  @override
  void initState() {
    super.initState();
    initFirebase();
    discussions = widget.forum.discussions;
    likes = widget.forum.likes;
    which = isLiked()
        ? Like.UPVOTE
        : isDisliked()
            ? Like.DOWNVOTE
            : Like.NEUTRAL;
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
                    child: Text(
                  widget.forum.comment,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )),
                IconButton(
                    onPressed: () {
                      if (which == Like.DOWNVOTE) {
                        print('in 2');
                        neutralDown(disabled: true);
                        upVote(like: 2);
                      } else if (which != Like.UPVOTE) {
                        upVote(like: 1);
                      } else {
                        neutralUp(disabled: false);
                      }
                    },
                    color:
                        which == Like.UPVOTE ? Colors.red[600] : kBorderButton,
                    icon: const Icon(Icons.arrow_circle_up)),
                Text(likes.toString()),
                IconButton(
                    onPressed: () async {
                      if (which == Like.UPVOTE) {
                        print('in 2');
                        neutralUp(disabled: true);
                        downVote(like: 2);
                      } else if (which != Like.DOWNVOTE) {
                        downVote(like: 1);
                      } else {
                        neutralDown(disabled: false);
                      }
                    },
                    color: which == Like.DOWNVOTE
                        ? Colors.blue[600]
                        : kBorderButton,
                    icon: Icon(Icons.arrow_circle_down_outlined)),
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
            context.read<UserProvider>().getRole() == 'College'
                ? Row(
                    children: [
                      Expanded(
                        child: Search(
                            controller: controller,
                            isUsedIcon: false,
                            text: this.comment,
                            onChanged: (String comment) {
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
                            // ignore: use_build_context_synchronously
                            'user': context.read<UserProvider>().getUsername(),
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
                  )
                : SizedBox(),
          ],
          // ),
        ),
      ),
    );
  }

  void upVote({required int like}) async {
    final db_forum_likes =
        await _firestore.collection('forums').doc(widget.forum.id).get();
    Map<String, dynamic> data = {'likes': db_forum_likes.get('likes') + like};
    _firestore
        .collection('forums')
        .doc(widget.forum.id)
        .set(data, SetOptions(merge: true));
    setState(() {
      likes = likes + 1;
    });
    final to_process_db_user = await _firestore
        .collection('users')
        .where(context.read<UserProvider>().getEmail())
        .get();
    final db_user_likes = to_process_db_user.docs[0].get('forum_likes');
    db_user_likes.add(widget.forum.id);
    _firestore
        .collection('users')
        .doc(to_process_db_user.docs[0].id)
        .set({'forum_likes': db_user_likes}, SetOptions(merge: true));
    context.read<UserProvider>().updateLikes(widget.forum.id);
    setState(() {
      which = Like.UPVOTE;
    });
  }

  void neutralDown({required bool disabled}) async {
    final db_forum_likes =
        await _firestore.collection('forums').doc(widget.forum.id).get();
    if (!disabled) {
      Map<String, dynamic> data = {'likes': db_forum_likes.get('likes') + 1};
      _firestore
          .collection('forums')
          .doc(widget.forum.id)
          .set(data, SetOptions(merge: true));
    }
    setState(() {
      likes = likes + 1;
    });
    final to_process_db_user = await _firestore
        .collection('users')
        .where(context.read<UserProvider>().getEmail())
        .get();
    final db_user_likes = to_process_db_user.docs[0].get('forum_dislikes');
    db_user_likes.remove(widget.forum.id);
    _firestore
        .collection('users')
        .doc(to_process_db_user.docs[0].id)
        .set({'forum_dislikes': db_user_likes}, SetOptions(merge: true));
    context.read<UserProvider>().removeDislikes(widget.forum.id);
    if (!disabled) {
      setState(() {
        which = Like.NEUTRAL;
      });
    }
  }

  void neutralUp({required bool disabled}) async {
    final db_forum_likes =
        await _firestore.collection('forums').doc(widget.forum.id).get();
    if (!disabled) {
      Map<String, dynamic> data = {'likes': db_forum_likes.get('likes') - 1};
      _firestore
          .collection('forums')
          .doc(widget.forum.id)
          .set(data, SetOptions(merge: true));
    }
    setState(() {
      likes = likes - 1;
    });
    final to_process_db_user = await _firestore
        .collection('users')
        .where(context.read<UserProvider>().getEmail())
        .get();
    final db_user_likes = to_process_db_user.docs[0].get('forum_likes');
    db_user_likes.remove(widget.forum.id);
    _firestore
        .collection('users')
        .doc(to_process_db_user.docs[0].id)
        .set({'forum_likes': db_user_likes}, SetOptions(merge: true));
    context.read<UserProvider>().removeLikes(widget.forum.id);
    if (!disabled) {
      setState(() {
        which = Like.NEUTRAL;
      });
    }
  }

  void downVote({required int like}) async {
    final db_forum_likes =
        await _firestore.collection('forums').doc(widget.forum.id).get();
    Map<String, dynamic> data = {'likes': db_forum_likes.get('likes') - like};
    _firestore
        .collection('forums')
        .doc(widget.forum.id)
        .set(data, SetOptions(merge: true));
    setState(() {
      likes = likes - 1;
    });
    final to_process_db_user = await _firestore
        .collection('users')
        .where(context.read<UserProvider>().getEmail())
        .get();
    final db_user_likes = to_process_db_user.docs[0].get('forum_dislikes');
    db_user_likes.add(widget.forum.id);
    _firestore
        .collection('users')
        .doc(to_process_db_user.docs[0].id)
        .set({'forum_dislikes': db_user_likes}, SetOptions(merge: true));
    context.read<UserProvider>().updateDislikes(widget.forum.id);
    setState(() {
      which = Like.DOWNVOTE;
    });
  }

  bool isLiked() {
    // return which == Like.UPVOTE;
    return context.read<UserProvider>().getLikes().contains(widget.forum.id);
  }

  bool isDisliked() {
    // return which = Lik
    return context.read<UserProvider>().getDislikes().contains(widget.forum.id);
  }
}

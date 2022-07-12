import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/data/forum_data.dart';
import 'package:cs_major_review/models/forum_model.dart';
import 'package:cs_major_review/pages/add_post_page.dart';
import 'package:cs_major_review/pages/discussion_page.dart';
import 'package:cs_major_review/pages/forum_filtering.dart';
import 'package:cs_major_review/providers/tags_provider.dart';
import 'package:cs_major_review/widgets/forum_bubble.dart';
import 'package:cs_major_review/widgets/forum_category.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

enum Category { TAG, RECENT, DISCUSS }

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);
  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  Category? which;
  late FirebaseFirestore _firestore;
  int id = 0;
  // List<Forum> forums = allForums;
  List<Forum> forums_ = [];
  @override
  void initState() {
    super.initState();
    initFirebaseAndFetchForums();
  }

  void initFirebaseAndFetchForums() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    getForums(withTag: false);
  }

  void getForums({required bool withTag}) async {
    final forums = await _firestore.collection('forums').get();
    forums_ = [];
    // print(forums.docs.length);
    for (var forum in forums.docs) {
      if (forum.data().isNotEmpty) {
        setState(() {
          forums_.add(Forum(
              topic: forum.get('topic'),
              user: forum.get('user'),
              createdBy: forum.get('createdAt'),
              comment: forum.get('comment'),
              num: 0,
              discussions: forum.get('discussions'),
              tags: forum.get('tags')));
        });
      }
      if (withTag) {
        getTaggedForums();
      }
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddPostPage(
        forums: forums_,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void refresh() {
    id++;
  }

  FutureOr goBackFilter(dynamic value) {
    getForums(withTag: true);
    // setState(() {});
    // print('yoyo');
    // setState(() {});
  }

  FutureOr goBackPost(dynamic value) {
    getForums(withTag: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).push(_createRoute()).then(goBackPost);
          },
          child: Container(
              // height: 8,
              height: 30,
              width: 90,
              decoration: BoxDecoration(
                border: Border.all(color: kStar, width: 1),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Icon(Icons.edit, color: kStar), Text('Post')],
              )),
        ),
        body: Container(
          child: Column(children: [
            Container(
              width: double.infinity,
              height: 220,
              padding: EdgeInsets.only(left: 40),
              color: Color(0xffFCEBB8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                      width: 10,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.menu_outlined,
                            color: Color(0xff0B2E27),
                          ),
                          onPressed: () {
                            setState(() {
                              which = Category.TAG;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForumFiltering(),
                              ),
                            ).then(goBackFilter);
                          }),
                    ),
                    SizedBox(
                      width: 40,
                    )
                  ]),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Forum",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      height: 60,
                      // height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ForumCategory(
                            onPressed_: (() {
                              setState(() {
                                which = Category.TAG;
                              });
                              getTaggedForums();
                            }),
                            text: "Featured Tags",
                            isSelected: which == Category.TAG,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ForumCategory(
                            onPressed_: (() async {
                              setState(() {
                                which = Category.RECENT;
                              });
                              // print(forums_.length);
                              getMostRecentForums();
                              // final forum = await _firestore
                              //     .collection('forums')
                              //     .doc('Yuqi')
                              //     .get();
                              // var discussions = forum.data()!['discussions'];
                              // Map<String, dynamic> discussion = {
                              //   'user': 'test',
                              //   'comment': '3'
                              // };
                              // if (discussions == null) {
                              //   Map<String, dynamic> discussions = {
                              //     'discussions': [
                              //       // {'user': 'test', 'comment': 'its mee'}
                              //       discussion
                              //     ]
                              //   };

                              //   _firestore
                              //       .collection('forums')
                              //       .doc('Yuqi')
                              //       .set(discussions);
                              // } else {
                              //   discussions.add(discussion);
                              //   Map<String, dynamic> to_db_discussions = {
                              //     'discussions': discussions
                              //   };
                              //   print(discussions);
                              //   _firestore.collection('forums').doc('Yuqi').set(
                              //       to_db_discussions, SetOptions(merge: true));
                              // }
                              // final discussions = forum;
                              // Map<String, dynamic> discussion = {
                              //   'discussion': [
                              //     {'user': 'test', 'comment': 'its mee'}
                              //   ]
                              // };
                              // _firestore
                              //     .collection('forums')
                              //     .doc('Yuqi')
                              //     // .collection('discussion')
                              //     // .doc()
                              //     .set(discussion, SetOptions(merge: true));
                              // _firestore
                              //     .collection('forums')
                              //     .doc('Minnie')
                              //     .set(discussion)
                              //     .onError((error, stackTrace) =>
                              //         print('Error with doc: $error'));
                            }),
                            text: "Most Recent",
                            isSelected: which == Category.RECENT,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ForumCategory(
                            onPressed_: (() {
                              setState(() {
                                which = Category.DISCUSS;
                              });
                              getMostDiscussedForums();
                            }),
                            text: "Most Discussed",
                            isSelected: which == Category.DISCUSS,
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Divider(
              color: Color(0xff102D24),
              thickness: 2,
              height: 0,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 440,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: List.generate(forums_.length, (index) {
                  // print(forums_.length);
                  return ForumBubble(
                    onTap_: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiscussonPage(
                            forum: forums_[index],
                            discussions: forums_[index].discussions,
                          ),
                        ),
                      ).then((value) => setState(() {
                            // getDiscussions();
                            goBackPost(value);
                          }));
                    },
                    forum: forums_[index],
                  );
                })),
              ),
            ),
          ]),
        ));
  }

  void getTaggedForums() {
    final taggedList =
        Provider.of<TagProvider>(context, listen: false).tags.toSet();
    if (taggedList.isNotEmpty) {
      final tempList = forums_
          .where((element) =>
              element.tags.toSet().intersection(taggedList).isNotEmpty)
          .toList();
      setState(() {
        this.forums_ = tempList;
      });
    }
    // else {
    //   setState(() {
    //     this.forums_ = forums_;
    //   });
    // }
    // allForums
    //     .where((ele) => ele.tags.contains(
    //           ,
    //         ))
    //     .toList();
    // print(allForums.length);
    // print(allForums[0].tags);
  }

  void getMostRecentForums() {
    forums_.sort(
      (a, b) {
        final dateA = a.createdBy.split(' ');
        final monthA = dateA[1];
        final dayA = dateA[2];
        final dateB = b.createdBy.split(' ');
        final monthB = dateB[1];
        final dayB = dateB[2];
        int numA = dateToNum(monthA, dayA);
        int numB = dateToNum(monthB, dayB);
        return (numB).compareTo(numA);
      },
    );
    setState() {
      this.forums_ = forums_;
    }
  }

  int dateToNum(String month, String day) {
    int? month_;
    switch (month) {
      case 'Jan':
        month_ = 0;
        break;
      case 'Feb':
        month_ = 31;
        break;
      case 'Mar':
        month_ = 59;
        break;
      case 'Apr':
        month_ = 90;
        break;
      case 'May':
        month_ = 120;
        break;
      case 'Jun':
        month_ = 151;
        break;
      case 'Jul':
        month_ = 181;
        break;
      case 'Aug':
        month_ = 212;
        break;
      case 'Sep':
        month_ = 243;
        break;
      case 'Oct':
        month_ = 273;
        break;
      case 'Nov':
        month_ = 304;
        break;
      case 'Dec':
        month_ = 334;
        break;
      default:
    }
    return (month_ == null) ? -1 : month_ + int.parse(day);
  }

  void getMostDiscussedForums() {
    forums_.sort(
      (a, b) => b.discussions.length.compareTo(a.discussions.length),
    );
    setState() {
      this.forums_ = forums_;
    }
  }
}

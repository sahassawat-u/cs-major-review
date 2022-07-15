import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/constaints.dart';
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
  late List<Forum> _forums;
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
    final dbForums = await _firestore.collection('forums').get();
    _forums = [];
    for (var forum in dbForums.docs) {
      if (forum.data().isNotEmpty) {
        setState(() {
          _forums.add(Forum(
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
        forums: _forums,
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

  FutureOr goBackFilter(dynamic value) {
    getForums(withTag: true);
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
            height: 30,
            width: 90,
            decoration: BoxDecoration(
              border: Border.all(color: kStar, width: 1),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Icon(Icons.edit, color: kStar), Text('Post')],
            ),
          ),
        ),
        body: Container(
          child: Column(children: [
            Container(
              width: double.infinity,
              height: 220,
              padding: EdgeInsets.only(left: 40),
              color: kForumStrip,
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
                            color: kNavBarIcon,
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
                        const SizedBox(
                          width: 20,
                        ),
                        ForumCategory(
                          onPressed_: (() async {
                            setState(() {
                              which = Category.RECENT;
                            });
                            getMostRecentForums();
                          }),
                          text: "Most Recent",
                          isSelected: which == Category.RECENT,
                        ),
                        const SizedBox(
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
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: kDivider,
              thickness: 2,
              height: 0,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: 440,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: List.generate(_forums.length, (index) {
                  return ForumBubble(
                    onTap_: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiscussonPage(
                            forum: _forums[index],
                            discussions: _forums[index].discussions,
                          ),
                        ),
                      ).then((value) => setState(() {
                            goBackPost(value);
                          }));
                    },
                    forum: _forums[index],
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
      final tempList = _forums
          .where((element) =>
              element.tags.toSet().intersection(taggedList).isNotEmpty)
          .toList();
      setState(() {
        this._forums = tempList;
      });
    }
  }

  void getMostRecentForums() {
    _forums.sort(
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
      this._forums = _forums;
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
    _forums.sort(
      (a, b) => b.discussions.length.compareTo(a.discussions.length),
    );
    setState() {
      this._forums = _forums;
    }
  }
}

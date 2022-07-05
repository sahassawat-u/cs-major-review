import 'package:cs_major_review/data/forum_data.dart';
import 'package:cs_major_review/models/forum_model.dart';
import 'package:cs_major_review/pages/forum_filtering.dart';
import 'package:cs_major_review/providers/tags_provider.dart';
import 'package:cs_major_review/widgets/forum_bubble.dart';
import 'package:cs_major_review/widgets/forum_category.dart';
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
  List<Forum> forums = allForums;
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        );
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
                        onPressed_: (() {
                          setState(() {
                            which = Category.RECENT;
                          });
                          getMostRecentForums();
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
          color: Color(0xff717664),
          thickness: 2,
          height: 0,
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          height: 500,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: List.generate(forums.length, (index) {
              return ForumBubble(
                forum: forums[index],
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
      final tempList = allForums
          .where((element) =>
              element.tags.toSet().intersection(taggedList).isNotEmpty)
          .toList();
      setState(() {
        this.forums = tempList;
      });
    } else {
      setState(() {
        this.forums = allForums;
      });
    }
    // allForums
    //     .where((ele) => ele.tags.contains(
    //           ,
    //         ))
    //     .toList();
    // print(allForums.length);
    // print(allForums[0].tags);
  }

  void getMostRecentForums() {
    allForums.sort(
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
      this.forums = allForums;
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
    allForums.sort(
      (a, b) => b.num.compareTo(a.num),
    );
    setState() {
      this.forums = allForums;
    }
  }
}

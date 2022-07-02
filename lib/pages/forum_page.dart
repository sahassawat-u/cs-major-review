import 'package:cs_major_review/pages/forum_filtering.dart';
import 'package:cs_major_review/widgets/forum_bubble.dart';
import 'package:cs_major_review/widgets/forum_category.dart';
import 'package:flutter/material.dart';

enum Category { TAG, RECENT, DISCUSS }

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);
  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  Category? which;
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
                          }),
                          text: "Most Discussed",
                          isSelected: which == Category.DISCUSS,
                        ),
                      ],
                    ))
              ],
            )),
        Divider(
          color: Color(0xff717664),
          thickness: 2,
          height: 0,
        ),
        SizedBox(height: 30),
        Container(
          height: 500,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                ForumBubble(),
                ForumBubble(),
                ForumBubble(),
                ForumBubble(),
                ForumBubble(),
              ])),
        ),
      ]),
    ));
  }
}

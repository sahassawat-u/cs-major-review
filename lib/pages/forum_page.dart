import 'package:cs_major_review/widgets/discussion.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
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
                  height: 50,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(Icons.search_outlined),
                  SizedBox(width: 8),
                  Icon(Icons.menu_outlined),
                  SizedBox(
                    width: 30,
                  )
                ]),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text("Forum",
                        style: TextStyle(
                          color: Color(0xff102D24),
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                        onSurface: Colors.red,
                      ),
                      // style: ButtonStyle(
                      //     foregroundColor:
                      //         MaterialStateProperty.all<Color>(Colors.blue)),
                      child: Text('Featured Tags'),
                      onPressed: () {},
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                        onSurface: Colors.red,
                      ),
                      // style: ButtonStyle(
                      //     foregroundColor:
                      //         MaterialStateProperty.all<Color>(Colors.blue)),
                      child: Text('Most Recent'),
                      onPressed: () {},
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                        onSurface: Colors.red,
                      ),
                      // style: ButtonStyle(
                      //     foregroundColor:
                      //         MaterialStateProperty.all<Color>(Colors.blue)),
                      child: Text('Most Discussed'),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            )),
        Divider(
          color: Color(0xff102D24),
          thickness: 2,
          height: 0,
        ),
        SizedBox(height: 30),
        Container(
            child: Column(
          children: [
            Discussion(),
            Discussion(),
          ],
        ))
      ]),
    ));
  }
}

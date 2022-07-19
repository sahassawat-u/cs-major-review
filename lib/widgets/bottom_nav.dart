import 'package:cs_major_review/pages/forum_page.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Column(children: [
        Divider(
          color: Color(0xff102D24),
          thickness: 2,
          height: 0,
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            GestureDetector(
              onTap: () {
                print('review');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForumPage(),
                  ),
                );
              },
              child: Column(children: [
                Icon(
                  Icons.rate_review,
                  color: Colors.grey[600],
                ),
                Text('Review', style: TextStyle(color: Colors.grey[600])),
              ]),
            ),
            GestureDetector(
              onTap: () {
                print('review');
              },
              child: Column(children: [
                Icon(Icons.forum),
                Text('Forum'),
              ]),
            ),
            GestureDetector(
              onTap: () {
                print('review');
              },
              child: Column(children: [
                Icon(Icons.edit),
                Text('Post'),
              ]),
            ),
            GestureDetector(
              onTap: () {
                print('review');
              },
              child: Column(children: [
                Icon(Icons.person),
                Text('Profile'),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }
}

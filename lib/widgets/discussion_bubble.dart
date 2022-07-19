import 'package:cs_major_review/providers/user_provider.dart';
import 'package:cs_major_review/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscussBubble extends StatelessWidget {
  final Map<String, dynamic> discussion;
  const DiscussBubble({Key? key, required this.discussion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        margin: EdgeInsets.symmetric(vertical: 20),
        // child: Column(
        // children: [
        child: Stack(
          children: [
            ProfilePicture(
                picture: discussion['picture'], width_: 40, height_: 40),
            // SizedBox(
            //   width: 30,
            // ),
            Container(
              margin: EdgeInsets.only(left: 60),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        discussion['user'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        // textAlign: TextAlign.start
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        discussion['comment'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                        // textAlign: TextAlign.start
                      ),
                    ],
                  ),
                  // Text(discussion['comment'])
                ],
              ),
            )
          ],
        ));
  }
}

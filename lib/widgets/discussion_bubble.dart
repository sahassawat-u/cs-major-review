import 'package:cs_major_review/models/discussion_model.dart';
import 'package:flutter/material.dart';

class DiscussBubble extends StatelessWidget {
  final Discussion discussion;
  const DiscussBubble({Key? key, required this.discussion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(discussion.user,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(discussion.comment),
                )
              ],
            )
          ],
        ));
  }
}
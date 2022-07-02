import 'package:flutter/material.dart';

class DiscussBubble extends StatelessWidget {
  const DiscussBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text("User ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                      "I really love this class, but it required a lot of disclipline, worth the reading and studying"),
                )
              ],
            )
          ],
        ));
  }
}

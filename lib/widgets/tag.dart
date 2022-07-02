import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;
  const Tag({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 20,
        bottom: 10,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        // horizontal: 15,
      ),
      width: 80,
      decoration: BoxDecoration(border: Border.all(color: Color(0xff122F2D))),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

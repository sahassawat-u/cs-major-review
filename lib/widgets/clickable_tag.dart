import 'package:cs_major_review/constaints.dart';
import 'package:flutter/material.dart';

class ClickableTag extends StatelessWidget {
  final String text;
  final VoidCallback onTap_;
  final bool isSelected;
  const ClickableTag(
      {Key? key,
      required this.text,
      required this.onTap_,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap_,
      child: Container(
        margin: EdgeInsets.only(
          right: 10,
          bottom: 10,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        height: 25,
        constraints: BoxConstraints(minWidth: 70),
        decoration: BoxDecoration(
            border: Border.all(color: kForumStrip),
            color: isSelected ? kForumStrip : Colors.white),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12, color: isSelected ? Colors.white : kForumStrip)),
      ),
    );
  }
}

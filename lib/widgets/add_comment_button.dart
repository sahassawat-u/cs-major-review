import 'package:cs_major_review/constaints.dart';
import 'package:flutter/material.dart';

class AddCommentButton extends StatelessWidget {
  const AddCommentButton({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        backgroundColor: kFontColor,
        onPressed: onPressed,
        child: const Icon(Icons.add_comment),
      ),
    );
  }
}

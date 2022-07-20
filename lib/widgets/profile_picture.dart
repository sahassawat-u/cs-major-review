import 'package:cs_major_review/constaints.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String picture;
  final double width_;
  final double height_;
  const ProfilePicture(
      {Key? key,
      required this.picture,
      required this.width_,
      required this.height_})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        // ranPic(),
        // 'https://firebasestorage.googleapis.com/v0/b/cs-major-connoisseur.appspot.com/o/files%2F1c1770dfaf21963f1ec443b8667787de-998985910.jpg?alt=media&token=1c7bd7e6-26dc-40ab-aec8-b494006560d0',
        picture ?? profilePicture,
        height: this.height_,
        width: this.width_,
      ),
    );
  }
}

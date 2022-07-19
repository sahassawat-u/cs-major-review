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
        picture,
        height: this.height_,
        width: this.width_,
      ),
    );
  }
}

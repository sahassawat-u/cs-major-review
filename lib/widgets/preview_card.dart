import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/widgets/profile_picture.dart';
import 'package:flutter/material.dart';

class PreviewCard extends StatelessWidget {
  final String comment;
  final String picture;
  const PreviewCard({Key? key, required this.comment, required this.picture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        picture.isNotEmpty && picture != null
            ? ProfilePicture(picture: picture, width_: 30, height_: 30)
            : SizedBox(),
        Container(
          margin: EdgeInsets.only(left: 42),
          height: 50,
          // color: Colors.blue,
          child: Text(
            comment,
            style: const TextStyle(color: kGreySubText),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}

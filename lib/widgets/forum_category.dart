import 'package:flutter/material.dart';

class ForumCategory extends StatelessWidget {
  final VoidCallback onPressed_;
  final bool isSelected;
  final String text;
  const ForumCategory(
      {Key? key,
      required this.text,
      required this.isSelected,
      required this.onPressed_})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: onPressed_,
            child: Text(this.text, style: TextStyle()),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(
                  isSelected ? Color(0xff082D26) : Colors.white),
              foregroundColor: MaterialStateProperty.all(
                  isSelected ? Colors.white : Color(0xff082D26)),
              side: MaterialStateProperty.all(
                  BorderSide(color: Color(0xff122F2D))),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            )),
        Container(
            margin: EdgeInsets.only(top: 1),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
                color: isSelected ? Color(0xff082D26) : Color(0xffFCEBB8),
                shape: BoxShape.circle)),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {

  const BaseCard({required this.theColor, required this.theChild, this.theOnTap, required this.theBorderColor});
  final Color theColor;
  final Color theBorderColor;
  final Widget theChild;
  final VoidCallback? theOnTap;
  // const means never changed
  // final you can set it once
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: theOnTap,
      child: Container(
        child: theChild,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: theColor,
            border: Border.all(color: theBorderColor),
            // borderRadius: BorderRadius.circular(7.0)
        ),
      ),
    );
  }
}
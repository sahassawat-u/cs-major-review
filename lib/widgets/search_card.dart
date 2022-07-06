import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constaints.dart';
import 'base_card.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseCard(
        theColor: Colors.white,
        theBorderColor: kSearchBorder,
        theChild: TextField(
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search for university"
          ),
        ),
      ),
    );
  }
}

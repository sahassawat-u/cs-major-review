import 'package:cs_major_review/pages/rating_page.dart';
import 'package:cs_major_review/widgets/base_card.dart';
import 'package:cs_major_review/widgets/university_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constaints.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      child: ListView(
        shrinkWrap: true,
        // itemBuilder: (context,_) =>
        //     ReviewCard(
        //
        //     )
        children: [
          UniversityCard(rating: 3, uni_name: "Mahidol University"),
          UniversityCard(rating: 5, uni_name: "Mahidol University")
        ],
      ),
    );
  }
}

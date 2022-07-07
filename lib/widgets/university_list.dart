import 'package:cs_major_review/data/unis_data.dart';
import 'package:cs_major_review/models/uni_model.dart';
import 'package:cs_major_review/pages/rating_page.dart';
import 'package:cs_major_review/widgets/base_card.dart';
import 'package:cs_major_review/widgets/university_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constaints.dart';

class ReviewList extends StatelessWidget {
  final List<University> unis;
  ReviewList({Key? key, required this.unis}) : super(key: key);

  // final unis = allUniReviews;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
          unis.length,
          (index) => UniversityCard(uni: unis[index]),
        ),
      ),
    );
  }
}

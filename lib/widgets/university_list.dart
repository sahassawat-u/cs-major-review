import 'package:cs_major_review/data/unis_data.dart';
import 'package:cs_major_review/models/uni_model.dart';
import 'package:cs_major_review/widgets/university_card.dart';
import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  final List<University> unis;
  const ReviewList({Key? key, required this.unis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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

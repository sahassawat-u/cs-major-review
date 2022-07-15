import 'package:cs_major_review/models/uni_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constaints.dart';
import '../pages/rating_page.dart';
import 'base_card.dart';

class UniversityCard extends StatelessWidget {
  final University uni;
  const UniversityCard({Key? key, required this.uni}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseCard(
          theOnTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RatingPage(uni: uni),
                ));
          },
          theColor: Colors.white,
          theChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: RatingBarIndicator(
                  rating: uni.rating,
                  itemCount: 5,
                  itemSize: 25.0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: kStar,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  uni.uni,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  uni.topComment,
                  style: const TextStyle(color: kGreySubText),
                ),
              ),
            ],
          ),
          theBorderColor: Colors.white),
    );
  }
}

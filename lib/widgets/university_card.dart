import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constaints.dart';
import '../pages/rating_page.dart';
import 'base_card.dart';
class UniversityCard extends StatelessWidget {
  const UniversityCard({Key? key, required this.rating, required this.uni_name}) : super(key: key);
  final double rating;
  final String uni_name;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseCard(
          theOnTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RatingPage(),
                )
            );},
          theColor: Colors.white,
          theChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: RatingBarIndicator(
                  rating: rating,
                  itemCount: 5,
                  itemSize: 25.0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: kStar,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child: Text(uni_name),
              ),
              SizedBox(height: 15,),
              // Container(
              //   child: Row(
              //     children: [
              //       Text("reviewed by Yu"),
              //       SizedBox(width: 200,),
              //       Text("Date")
              //     ],
              //   ),
              // ),
              // SizedBox(height: 15,),
              Container(
                child: Text("Preview..."),
              ),

            ],
          ),
          theBorderColor: Colors.white),
    );
  }
}

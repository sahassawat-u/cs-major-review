import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'base_card.dart';
class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseCard(
          theColor: Colors.white,
          theChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: RatingBarIndicator(
                  rating: 4,
                  itemCount: 5,
                  itemSize: 25.0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child: Text("Mahidol University"),
              ),
              SizedBox(height: 15,),
              Container(
                child: Row(
                  children: [
                    Text("reviewed by Yu"),
                    SizedBox(width: 200,),
                    Text("Date")
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child: Text("Preview..."),
              ),

            ],
          ),
          theBorderColor: Colors.white),
    );
  }
}

import 'dart:async';

import 'package:cs_major_review/models/review_model.dart';
import 'package:cs_major_review/widgets/preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constaints.dart';
import 'base_card.dart';

class UniversityCard extends StatelessWidget {
  final Review review;
  final VoidCallback onTap_;
  const UniversityCard({Key? key, required this.review, required this.onTap_})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseCard(
          theOnTap: onTap_,
          theColor: Colors.white,
          theChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              review.comments.length > 0
                  ? Container(
                      child: RatingBarIndicator(
                        rating: review.rating,
                        itemCount: 5,
                        itemSize: 25.0,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: kStar,
                        ),
                      ),
                    )
                  : Text('No rating yet',
                      style: TextStyle(color: kGreySubText)),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  review.uni,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              review.comments.length > 0
                  ? PreviewCard(
                      comment: review.comments[review.comments.length - 1]
                          ['comment'],
                      picture: review.comments[review.comments.length - 1]
                              ['picture'] ??
                          profilePicture)
                  : Text('No comment yet'),
            ],
          ),
          theBorderColor: Colors.white),
    );
  }
}

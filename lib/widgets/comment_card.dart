import 'package:cs_major_review/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constaints.dart';
import 'base_card.dart';

class CommentCard extends StatefulWidget {
  CommentCard({
    Key? key,
    required this.rating,
    required this.title,
    required this.comment,
    required this.date,
    required this.reviewed_name,
    required this.picture,
  }) : super(key: key);
  final double rating;
  final String title;
  final String comment;
  final String date;
  final String reviewed_name;
  final String picture;
  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  Color _color = kStar;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BaseCard(
          theColor: Colors.white,
          theChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: RatingBarIndicator(
                  rating: widget.rating,
                  itemCount: 5,
                  itemSize: 20,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: kStar,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ProfilePicture(
                      picture: widget.picture, width_: 30, height_: 30),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text("created By ",
                              style: TextStyle(
                                  color: Color(0xffB2B9B9), fontSize: 15)),
                          Text(widget.reviewed_name)
                        ],
                      ),
                    ),
                    Text(widget.date, style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  widget.comment,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              )
            ],
          ),
          theBorderColor: Colors.white),
    );
  }
}

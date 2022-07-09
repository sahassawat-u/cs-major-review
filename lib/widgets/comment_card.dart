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
    required this.like,
  }) : super(key: key);
  int like;
  final double rating;
  final String title;
  final String comment;
  final String date;
  final String reviewed_name;

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
              Container(
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
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
                    // Text("Reviewed by ${widget.reviewed_name}",
                    //     style: TextStyle(
                    //         fontSize: 15, color: Color(0xffB2B9B9)))),
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
              Container(
                // margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: _color)),
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  color: _color,
                  onPressed: () {
                    setState(() {
                      _color = Colors.pinkAccent;
                      widget.like += 1;
                    });
                    // print("Liked");
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 5, 0, 0),
                  child: Text(widget.like.toString())),
              SizedBox(
                height: 10,
              )
            ],
          ),
          theBorderColor: Colors.white),
    );
  }
}

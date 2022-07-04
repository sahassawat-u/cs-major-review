import 'package:cs_major_review/widgets/base_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class CommentList extends StatelessWidget {
  const CommentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 10,
      child: ListView(
        shrinkWrap: true,
        children: [
          BaseCard(
              theColor: Colors.white,
              theChild: Row(
                children: [
                  Container(
                    height: 60,
                    child: CircleAvatar(
                    )
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name"),
                      Text("Comment")
                    ],
                  ),
                  Spacer(flex: 2),
                  Container(
                    child:
                    Column(
                      children: [
                        Text("Rate: 4"),
                        Container(
                          child: RatingBarIndicator(
                            rating: 4,
                            itemCount: 5,
                            itemSize: 15.0,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                          ),
                        ),
                      ],
                    ),

                  )
                ],
              ),
              theBorderColor: Colors.white),
          BaseCard(
              theColor: Colors.white,
              theChild: Row(
                children: [
                  Container(
                      height: 60,
                      child: CircleAvatar(
                      )
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name"),
                      Text("Comment")
                    ],
                  ),
                  Spacer(flex: 2),
                  Container(
                    child:
                    Column(
                      children: [
                        Text("Rate: 4"),
                        Container(
                          child: RatingBarIndicator(
                            rating: 4,
                            itemCount: 5,
                            itemSize: 15.0,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                          ),
                        ),
                      ],
                    ),

                  )
                ],
              ),
              theBorderColor: Colors.white),
          BaseCard(
              theColor: Colors.white,
              theChild: Row(
                children: [
                  Container(
                      height: 60,
                      child: CircleAvatar(
                      )
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name"),
                      Text("Comment")
                    ],
                  ),
                  Spacer(flex: 2),
                  Container(
                    child:
                    Column(
                      children: [
                        Text("Rate: 4"),
                        Container(
                          child: RatingBarIndicator(
                            rating: 4,
                            itemCount: 5,
                            itemSize: 15.0,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                          ),
                        ),
                      ],
                    ),

                  )
                ],
              ),
              theBorderColor: Colors.white),
          BaseCard(
              theColor: Colors.white,
              theChild: Row(
                children: [
                  Container(
                      height: 60,
                      child: CircleAvatar(
                      )
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name"),
                      Text("Comment")
                    ],
                  ),
                  Spacer(flex: 2),
                  Container(
                    child:
                    Column(
                      children: [
                        Text("Rate: 4"),
                        Container(
                          child: RatingBarIndicator(
                            rating: 4,
                            itemCount: 5,
                            itemSize: 15.0,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                          ),
                        ),
                      ],
                    ),

                  )
                ],
              ),
              theBorderColor: Colors.white),
          BaseCard(
              theColor: Colors.white,
              theChild: Row(
                children: [
                  Container(
                      height: 60,
                      child: CircleAvatar(
                      )
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name"),
                      Text("Comment")
                    ],
                  ),
                  Spacer(flex: 2),
                  Container(
                    child:
                    Column(
                      children: [
                        Text("Rate: 4"),
                        Container(
                          child: RatingBarIndicator(
                            rating: 4,
                            itemCount: 5,
                            itemSize: 15.0,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                          ),
                        ),
                      ],
                    ),

                  )
                ],
              ),
              theBorderColor: Colors.white)
        ],
      ),
    );
  }
}

import 'package:cs_major_review/pages/rating_page.dart';
import 'package:cs_major_review/widgets/base_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
          BaseCard(
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
          BaseCard(
              theOnTap: (){
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => RatingPage())

                );
              },
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
              theBorderColor: Colors.white)
        ],
      ),
    );
  }
}

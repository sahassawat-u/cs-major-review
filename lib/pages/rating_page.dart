import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constaints.dart';
import '../widgets/base_card.dart';
import '../widgets/comment_list.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double? _ratingValue;
  void RateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 150,
            child: Column(
              children: [
                Container(
                  child: Text("Rate your university",
                    style: TextStyle(fontSize: 20)),
                ),
                SizedBox(height: 15,),
                Container(

                  child: RatingBar(
                      initialRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star, color: Colors.orange),
                          half: const Icon(
                            Icons.star_half,
                            color: Colors.orange,
                          ),
                          empty: const Icon(
                            Icons.star_outline,
                            color: Colors.orange,
                          )),
                      onRatingUpdate: (value) {
                        setState(() {
                          _ratingValue = value;
                        });
                      }),
                ),
                SizedBox(height: 15,),
                Container(
                    child: ElevatedButton(
                      onPressed: () { print(_ratingValue); },
                      child: Text("Submit"),
                      style: ElevatedButton.styleFrom(
                        primary: kFontColor
                      ),

                    ),

                  )

              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(

        child: Column(
          children: [
            SizedBox(height: 50,),
            Container(

              child: Text("Mahidol University",
                style: TextStyle(fontSize: 20),),
            ),
            Container(
              child: RatingBarIndicator(
                rating: 4,
                itemCount: 5,
                itemSize: 25.0,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, _) =>
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
             ),
            ),
            Container(
              child: CommentList(),
            ),
            Spacer(flex:2),
            Container(
              child: BaseCard(
                theColor: Colors.white,
                theBorderColor: kSearchBorder,
                theChild: Container(
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.comment_sharp),
                        hintText: "Share your thought",
                        suffixIcon: IconButton(

                          icon: Icon(Icons.send),
                          onPressed: () {
                              RateDialog();
                          },
                        )

                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

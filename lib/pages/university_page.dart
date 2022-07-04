import 'package:cs_major_review/constaints.dart';
// import 'package:cs_major_review/university_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_card.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/university_list.dart';
class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 400,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      color: kBackgroundColor1,
                      child: Container(
                        padding: EdgeInsets.all(85),
                        child: BaseCard(
                          theChild: const Text("Search for your university",
                            style: TextStyle(color: kFontColor,fontSize: 30),),
                          theColor: kBackgroundColor1,
                          theBorderColor: kBackgroundColor1,
                        ),
                      ),
                    ),
                  ],
                ),

                Positioned(
                  top: 310,
                  left: 50,
                  right: 50,

                    child: BaseCard(
                      theColor: Colors.white,
                      theBorderColor: kSearchBorder,
                      theChild: TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search for university"
                        ),
                      ),
                    ),

                  ),
                // Divider(color: kFontColor,),
                // Container()
              ],
            ),
          ),
          // Divider(color: kFontColor,),
         ReviewList(),
        ],
      ),

    );
  }
}

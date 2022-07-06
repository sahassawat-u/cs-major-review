import 'package:cs_major_review/constaints.dart';
// import 'package:cs_major_review/university_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/base_card.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/search_card.dart';
import '../widgets/university_list.dart';
class UniversityPage extends StatefulWidget {
  const UniversityPage({Key? key}) : super(key: key);

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
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
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kFontColor,fontSize: 35),),
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

                    child: SearchCard()

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

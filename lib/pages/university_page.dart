import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/data/unis_data.dart';
import 'package:cs_major_review/models/uni_model.dart';
import 'package:cs_major_review/widgets/search.dart';
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
  TextEditingController controller = TextEditingController();
  String query = '';
  List<University> unis = allUniReviews;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: 300,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        // color: Colors.black,
                        color: kBackgroundColor1,
                        child:
                            //  Container(
                            //   padding: EdgeInsets.all(65),
                            //   child: Search(
                            //     controller: controller,
                            //     isUsedIcon: true,
                            //     text: query,
                            //     onChanged: searchUni,
                            //     hintText: "Search for university",
                            //   ),
                            Container(
                          padding:
                              EdgeInsets.only(left: 65, right: 65, top: 90),
                          child: BaseCard(
                            theChild: const Text(
                              "Search for your university",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: kFontColor, fontSize: 30),
                            ),
                            theColor: kBackgroundColor1,
                            theBorderColor: kBackgroundColor1,
                          ),
                        )),
                    Divider(
                      color: kFontColor,
                      thickness: 2,
                      height: 2,
                    ),
                  ],
                ),

                Positioned(
                  top: 215,
                  left: 50,
                  right: 50,
                  child: Container(
                    child: Search(
                      controller: controller,
                      isUsedIcon: true,
                      text: query,
                      onChanged: searchUni,
                      hintText: "Search for university",
                    ),
                  ),
                )
                // Divider(color: kFontColor,),
                // Container()
              ],
            ),
          ),
          ReviewList(
            unis: unis,
          ),
        ],
      ),
    );
  }

  void searchUni(String query) {
    final newUnis = allUniReviews.where((uni) {
      final name = uni.uni.toLowerCase();
      final search = query.toLowerCase();
      return name.contains(search);
    }).toList();
    setState(() {
      this.query = query;
      this.unis = newUnis;
    });
  }
  // void searchUni(String query) {
  //   final newUnis = j
  // }
}

import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/data/unis_data.dart';
import 'package:cs_major_review/models/uni_model.dart';
import 'package:cs_major_review/widgets/search.dart';
import 'package:flutter/material.dart';
import '../widgets/base_card.dart';
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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
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
                        color: kBackgroundColor1,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 65, right: 65, top: 90),
                          child: const BaseCard(
                            theChild: Text(
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
              ],
            ),
          ),
          ReviewList(
            unis: unis,
          )
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
}

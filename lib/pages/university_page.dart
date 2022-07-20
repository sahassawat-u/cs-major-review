import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/models/review_model.dart';
import 'package:cs_major_review/pages/rating_page.dart';
import 'package:cs_major_review/providers/firebase_provider.dart';
import 'package:cs_major_review/providers/geolocator_provider.dart';
import 'package:cs_major_review/providers/unis_provider.dart';
import 'package:cs_major_review/widgets/base_card.dart';
import 'package:cs_major_review/widgets/search.dart';
import 'package:cs_major_review/widgets/university_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UniversityPage extends StatefulWidget {
  const UniversityPage({Key? key}) : super(key: key);

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  TextEditingController controller = TextEditingController();
  String query = '';
  List<Review> _reviews = [];
  List<Review> _displayedReviews = [];
  late FirebaseFirestore _firestore;
  @override
  void initState() {
    super.initState();
    _firestore = context.read<FirebaseProvider>().getFirestore();
    getReviews();
  }

  void addUnisToDB() {
    final unis = context.read<UniProvider>().getUnis();
    for (var uni in unis) {
      Map<String, dynamic> review = {
        'uni': uni.schoolNameEng,
        'lat': double.parse(uni.latitude ?? '0.0'),
        'long': double.parse(uni.longitude ?? '0.0'),
        'rating': 0.0,
        'comments': [],
      };
      _firestore.collection('reviews').add(review);
    }
  }

  void getReviews() async {
    final dbReviews = await _firestore.collection('reviews').get();
    _reviews = [];
    for (var review in dbReviews.docs) {
      if (review.data().isNotEmpty) {
        setState(() {
          _reviews.add(Review(
              uni: review.get('uni'),
              rating: review.get('rating'),
              lat: review.get('lat'),
              long: review.get('long'),
              comments: review.get('comments')));
        });
      }
    }
    final userLat = context.read<GeolocatorProvider>().getLat();
    final userLong = context.read<GeolocatorProvider>().getLong();
    // final userLat = 13.907967562084865;
    // final userLong = 100.43797301759966;
    _reviews.sort(((a, b) {
      final aDistance =
          pow(pow((a.lat - userLat), 2) + pow((a.long - userLong), 2), 1 / 2);
      final bDistance =
          pow(pow((b.lat - userLat), 2) + pow((b.long - userLong), 2), 1 / 2);
      print('-----');
      return aDistance.compareTo(bDistance);
    }));
    setState(() {
      this._reviews = _reviews;
      this._displayedReviews = _reviews;
    });
  }

  FutureOr goBackReview(dynamic value) {
    getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          // children: [],
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
                                style:
                                    TextStyle(color: kFontColor, fontSize: 30),
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 400,
              child: ListView(
                shrinkWrap: true,
                children: List.generate(
                  _displayedReviews.length,
                  (index) => UniversityCard(
                    review: _displayedReviews[index],
                    onTap_: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RatingPage(
                            review: _displayedReviews[index],
                          ),
                        ),
                      ).then((value) => setState(() {
                            goBackReview(value);
                            // goBackPost(value);
                          }));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchUni(String query) {
    final newUnis = _reviews.where((uni) {
      final name = uni.uni.toLowerCase();
      final search = query.toLowerCase();
      return name.contains(search);
    }).toList();
    setState(() {
      this.query = query;
      _displayedReviews = newUnis;
    });
  }
}

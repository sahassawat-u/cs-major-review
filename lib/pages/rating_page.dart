import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/models/comment_model.dart';
import 'package:cs_major_review/models/review_model.dart';
import 'package:cs_major_review/pages/add_comment_page.dart';
import 'package:cs_major_review/providers/firebase_provider.dart';
import 'package:cs_major_review/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constaints.dart';
import '../widgets/comment_list.dart';
import 'package:provider/provider.dart';

class RatingPage extends StatefulWidget {
  final Review review;
  const RatingPage({Key? key, required this.review}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double? _ratingValue;
  List<dynamic> comments = [];
  late FirebaseFirestore _firestore;
  @override
  void initState() {
    super.initState();
    _firestore = context.read<FirebaseProvider>().getFirestore();
    comments = widget.review.comments;
  }

  void getComments() async {
    final data = await _firestore
        .collection('reviews')
        .where('uni', isEqualTo: widget.review.uni)
        .get();
    final comments =
        await _firestore.collection('reviews').doc(data.docs[0].id).get();
    setState(() {
      this.comments = comments.data()!['comments'];
    });
    getMostRecentComments();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddCommentPage(
        uniName: widget.review.uni,
        comments: widget.review.comments,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: context.read<UserProvider>().getRole() == 'College'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(_createRoute())
                    .then((value) => setState(() {
                          getComments();
                        }));
              },
              backgroundColor: kStar,
              child: const Icon(Icons.add_comment),
            )
          : null,
      // resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text("Back")
              ],
            ),
            Container(
              child: Text(
                widget.review.uni + " Univeristy",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            widget.review.comments.length > 0
                ? Container(
                    child: RatingBarIndicator(
                      rating: widget.review.rating,
                      itemCount: 5,
                      itemSize: 25.0,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: kStar,
                      ),
                    ),
                  )
                : Text('No rating yet', style: TextStyle(color: kGreySubText)),
            this.comments.length > 0
                ? Flexible(
                    child: CommentList(comments: this.comments),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Text('No comment yet'),
                  )
          ],
        ),
      ),
    );
  }

  void getMostRecentComments() {
    comments.sort(
      (a, b) {
        final dateA = a['createdAt'].split(' ');
        final monthA = dateA[1];
        final dayA = dateA[2];
        final dateB = b['createdAt'].split(' ');
        final monthB = dateB[1];
        final dayB = dateB[2];
        int numA = dateToNum(monthA, dayA);
        int numB = dateToNum(monthB, dayB);
        return (numB).compareTo(numA);
      },
    );
    setState(() {
      comments = comments;
    });
    // return widget.review.comments;
  }

  int dateToNum(String month, String day) {
    int? month_;
    switch (month) {
      case 'Jan':
        month_ = 0;
        break;
      case 'Feb':
        month_ = 31;
        break;
      case 'Mar':
        month_ = 59;
        break;
      case 'Apr':
        month_ = 90;
        break;
      case 'May':
        month_ = 120;
        break;
      case 'Jun':
        month_ = 151;
        break;
      case 'Jul':
        month_ = 181;
        break;
      case 'Aug':
        month_ = 212;
        break;
      case 'Sep':
        month_ = 243;
        break;
      case 'Oct':
        month_ = 273;
        break;
      case 'Nov':
        month_ = 304;
        break;
      case 'Dec':
        month_ = 334;
        break;
      default:
    }
    return (month_ == null) ? -1 : month_ + int.parse(day);
  }
}

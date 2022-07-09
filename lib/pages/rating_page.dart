import 'package:cs_major_review/models/comment_model.dart';
import 'package:cs_major_review/models/uni_model.dart';
import 'package:cs_major_review/pages/add_comment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constaints.dart';
import '../widgets/base_card.dart';
import '../widgets/comment_list.dart';

class RatingPage extends StatefulWidget {
  final University uni;
  const RatingPage({Key? key, required this.uni}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double? _ratingValue;
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddCommentPage(
        uniName: widget.uni.uni,
        comments: widget.uni.comments,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(_createRoute())
              .then((value) => setState(() {}));
        },
        backgroundColor: kStar,
        child: const Icon(Icons.add_comment),
      ),
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
                widget.uni.uni + " Univeristy",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              child: RatingBarIndicator(
                rating: widget.uni.rating,
                itemCount: 5,
                itemSize: 25.0,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: kStar,
                ),
              ),
            ),
            Flexible(
              child: CommentList(comments: getMostRecentComments()),
            ),
          ],
        ),
      ),
    );
  }

  List<Comment> getMostRecentComments() {
    widget.uni.comments.sort(
      (a, b) {
        final dateA = a.createdDate.split(' ');
        final monthA = dateA[1];
        final dayA = dateA[2];
        final dateB = b.createdDate.split(' ');
        final monthB = dateB[1];
        final dayB = dateB[2];
        int numA = dateToNum(monthA, dayA);
        int numB = dateToNum(monthB, dayB);
        return (numB).compareTo(numA);
      },
    );
    return widget.uni.comments;
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

import 'package:cs_major_review/pages/add_comment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constaints.dart';
import '../widgets/add_comment_button.dart';
import '../widgets/base_card.dart';
import '../widgets/comment_list.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double? _ratingValue;
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const AddCommentPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          backgroundColor: kStar,
          child: const Icon(Icons.add_comment),

          ),
      // resizeToAvoidBottomInset: false,
      body: Column(
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
                    color: kStar,
                  ),
           ),
          ),
          Flexible(

            child: CommentList(),
          ),
          // Spacer(flex:2),
          // Container(
          //   child: AddCommentButton(
          //     onPressed: () {
          //       Navigator.of(context).push(_createRoute());
          //     },
          //   )
          //
          // )
        ],
      ),
    );

  }
}

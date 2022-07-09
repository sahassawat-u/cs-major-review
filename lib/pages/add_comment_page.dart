import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/models/comment_model.dart';
import 'package:cs_major_review/widgets/search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/base_card.dart';

class AddCommentPage extends StatefulWidget {
  final List<Comment> comments;
  final String uniName;
  const AddCommentPage(
      {Key? key, required this.comments, required this.uniName})
      : super(key: key);

  @override
  State<AddCommentPage> createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  late String title;
  late String comment;
  double? _ratingValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kStar,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                margin: EdgeInsets.all(15),
                //  padding: EdgeInsets.,
                child: Text(
                  "To " + widget.uniName + " :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )),
            Container(
                child: BaseCard(
              theColor: Colors.white,
              theBorderColor: Colors.white,
              theChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Review Title"),
                  ),
                  Container(
                    child: TextField(
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter the Title",
                      ),
                    ),
                  )
                ],
              ),
            )),
            Container(
                child: BaseCard(
              theColor: Colors.white,
              theBorderColor: Colors.white,
              theChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("What's your rate?"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: RatingBar(
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: kFontColor),
                            half: const Icon(
                              Icons.star_half,
                              color: kStar,
                            ),
                            empty: const Icon(
                              Icons.star_border,
                              color: kStar,
                            )),
                        onRatingUpdate: (value) {
                          setState(() {
                            _ratingValue = value;
                          });
                        }),
                  ),
                ],
              ),
            )),
            Container(
                child: BaseCard(
              theColor: Colors.white,
              theBorderColor: Colors.white,
              theChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Your comment"),
                  ),
                  Container(
                    child: BaseCard(
                      theColor: Colors.white,
                      theBorderColor: kFontColor,
                      theChild: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextField(
                            onChanged: (value) {
                              comment = value;
                            },
                            minLines:
                                6, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Write your comment here...",
                              // focusColor: Colors.white
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(
                              //     color: kFontColor,
                              //     width: 2.0,
                              //   )
                            )),
                      ),
                    ),
                  )
                ],
              ),
            )),
            // Spacer(flex:2),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    widget.comments.add(Comment(
                        user: "Tester",
                        comment: comment,
                        title: title,
                        createdDate: "Fri Jun 8 2022",
                        like: 0,
                        rating: _ratingValue ?? 0));
                    Navigator.of(context).pop(() {
                      setState(() {});
                    });
                    print("submitted $title, $comment, $_ratingValue");
                  },
                  child: Text("Submit Your Review"),
                  style: ElevatedButton.styleFrom(primary: kStar),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

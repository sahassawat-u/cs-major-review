import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/providers/firebase_provider.dart';
import 'package:cs_major_review/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/base_card.dart';

class AddCommentPage extends StatefulWidget {
  final List<dynamic> comments;
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
  late FirebaseFirestore _firestore;
  @override
  void initState() {
    super.initState();
    _firestore = context.read<FirebaseProvider>().getFirestore();
  }

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
                  onPressed: () async {
                    final db_data = await _firestore
                        .collection('reviews')
                        .where('uni', isEqualTo: widget.uniName)
                        .get();
                    final to_process_comments = await _firestore
                        .collection('reviews')
                        .doc(db_data.docs[0].id)
                        .get();
                    final comments = to_process_comments.data()!['comments'];
                    Map<String, dynamic> newComment = {
                      'user': context.read<UserProvider>().getUsername(),
                      'comment': comment,
                      'title': title,
                      'createdAt':
                          DateFormat("EEE MMM dd yyyy").format(DateTime.now()),
                      'rating': _ratingValue ?? 0
                    };
                    comments.add(newComment);
                    Map<String, dynamic> toUseComments = {'comments': comments};
                    _firestore
                        .collection('reviews')
                        .doc(db_data.docs[0].id)
                        .set(toUseComments, SetOptions(merge: true));
                    final currentRating = to_process_comments.data()!['rating'];
                    print(comments.length);
                    _firestore
                        .collection('reviews')
                        .doc(db_data.docs[0].id)
                        .set({
                      'rating': (currentRating + _ratingValue) / comments.length
                    }, SetOptions(merge: true));
                    Navigator.of(context).pop();
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

import 'package:cs_major_review/widgets/tag.dart';
import 'package:flutter/material.dart';

class ForumFiltering extends StatefulWidget {
  const ForumFiltering({Key? key}) : super(key: key);

  @override
  State<ForumFiltering> createState() => _ForumFilteringState();
}

class _ForumFilteringState extends State<ForumFiltering> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text("Back")
                ],
              ),
              Row(
                children: [
                  Text(
                    "University",
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Search for uni")),
              SizedBox(height: 15),
              Container(
                color: Colors.red,
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tag(
                      text: "DSOOP",
                    ),
                    Tag(
                      text: "ALGO",
                    ),
                    Tag(
                      text: "DSOOP",
                    ),
                    Expanded(
                      child: Tag(
                        text: "DSOOP",
                      ),
                    ),
                    // Tag(
                    //   text: "DSOOP",
                    // ),
                  ],
                ),
              ),
              Row(children: [
                Text(
                  "Course",
                  textAlign: TextAlign.start,
                ),
              ]),
              SizedBox(height: 15),
              Wrap(

                  // crossAxisAlignment: WrapCrossAlignment.start,
                  // color: Colors.red,
                  // height: 400,
                  children: [
                    Tag(text: "TESTSTETT"),
                    Tag(text: "TESTSTETT"),
                    Tag(text: "TESTSTETT"),
                    Tag(text: "TESTSTETT"),
                    Tag(text: "DSss"),
                    Tag(text: "DSss"),
                    Tag(text: "DSss"),
                    Tag(text: "x"),
                    Tag(text: "x"),
                    Tag(text: "x"),
                  ]),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Tag(
              //       text: "DSOOP",
              //     ),
              //     Tag(
              //       text: "ALGO",
              //     ),
              //     Tag(
              //       text: "D",
              //     ),
              //     Expanded(
              //       child: Tag(
              //         text: "DSOOP",
              //       ),
              //     ),
              //     // Tag(
              //     //   text: "DSOOP",
              //     // ),
              //     // Tag(
              //     //   text: "DSOOP",
              //     // ),
              //     // Tag(
              //     //   text: "DSOOP",
              //     // ),
              //   ],
              // ),
              SizedBox(
                height: 30,
              ),
              Container(
                // padding: const EdgeInsets.only(right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Apply", style: TextStyle()),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Color(0xff082D26)),
                            side: MaterialStateProperty.all(
                                BorderSide(color: Color(0xff122F2D))),
                            // padding: MaterialStateProperty.all(
                            //   EdgeInsets.symmetric(horizontal: 50),
                            // ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Reset", style: TextStyle()),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Color(0xff082D26)),
                            side: MaterialStateProperty.all(
                                BorderSide(color: Color(0xff122F2D))),
                            // padding: MaterialStateProperty.all(
                            //   EdgeInsets.symmetric(horizontal: 50),
                            // ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

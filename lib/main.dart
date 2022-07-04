import 'package:cs_major_review/pages/university_page.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'AveriaSerifLibre',
      ),
      home: ReviewPage(),
    );
  }
}



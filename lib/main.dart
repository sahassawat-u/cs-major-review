import 'package:flutter/material.dart';
import 'package:cs_major_review/pages/forum_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'AveriaSerifLibre',
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(bodyColor: const Color(0xff082D26)),
      ),
      title: 'CS Major review',
      home: ForumPage(),
    );
  }
}

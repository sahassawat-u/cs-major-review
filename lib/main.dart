import 'package:flutter/material.dart';
import 'package:cs_major_review/pages/forum_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CS Major review',
      home: ForumPage(),
    );
  }
}

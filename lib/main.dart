
import 'package:cs_major_review/providers/tags_provider.dart';
import 'package:flutter/material.dart';
import 'package:cs_major_review/pages/forum_page.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TagProvider()),
    ],
    child: const MyApp(),
  ));
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


      ),
      home: UniversityPage(),

    );
  }
}



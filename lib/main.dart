import 'package:cs_major_review/pages/university_page.dart';
import 'package:cs_major_review/pages/welcome_page.dart';
import 'package:cs_major_review/providers/tags_provider.dart';
import 'package:flutter/material.dart';
import 'package:cs_major_review/pages/forum_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TagProvider()),
    ],
    child: MyApp(
      firstPage: false,
    ),
  ));
}

class MyApp extends StatefulWidget {
  bool firstPage = false;
  MyApp({Key? key, required this.firstPage}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final screens = [
    UniversityPage(),
    ForumPage(),
    Center(child: Text('Profile')),
  ];
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
        home: widget.firstPage
            ? WelcomePage(onRegister: () {})
            : Scaffold(
                body: IndexedStack(
                  index: currentIndex,
                  children: screens,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: Color(0xff021A17),
                  unselectedItemColor: Colors.grey[600],
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) => setState(() => currentIndex = index),
                  currentIndex: currentIndex,
                  items: [
                    BottomNavigationBarItem(
                      label: "Review",
                      icon: Icon(Icons.rate_review),
                      backgroundColor: Color(0xff021A17),
                    ),
                    BottomNavigationBarItem(
                      label: "Forum",
                      icon: Icon(Icons.forum),
                      backgroundColor: Color(0xff021A17),
                    ),
                    // BottomNavigationBarItem(
                    //   label: "Post",
                    //   icon: Icon(Icons.edit),
                    //   backgroundColor: Color(0xff021A17),
                    // ),
                    BottomNavigationBarItem(
                      label: "Profile",
                      icon: Icon(Icons.person),
                      backgroundColor: Color(0xff021A17),
                    ),
                  ],
                ),
              ));
  }
}

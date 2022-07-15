import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/pages/university_page.dart';
import 'package:cs_major_review/pages/welcome_page.dart';
import 'package:cs_major_review/providers/geolocator_provider.dart';
import 'package:cs_major_review/providers/tags_provider.dart';
import 'package:flutter/material.dart';
import 'package:cs_major_review/pages/forum_page.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TagProvider()),
      ChangeNotifierProvider(create: (_) => GeolocatorProvider()),
    ],
    child: MyApp(
      firstPage: false,
    ),
  ));
}

class MyApp extends StatefulWidget {
  bool firstPage;
  MyApp({Key? key, required this.firstPage}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  late LocationPermission permission;
  final screens = [
    UniversityPage(),
    ForumPage(),
    Center(child: Text('Profile')),
  ];
  @override
  void initState() {
    super.initState();
    context.read<GeolocatorProvider>().initGeo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'AveriaSerifLibre',
          textTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(bodyColor: kFontColor),
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
                  selectedItemColor: kNavBarIcon,
                  unselectedItemColor: Colors.grey[600],
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) => setState(() => currentIndex = index),
                  currentIndex: currentIndex,
                  items: [
                    BottomNavigationBarItem(
                      label: "Review",
                      icon: Icon(Icons.rate_review),
                      backgroundColor: kNavBarIcon,
                    ),
                    BottomNavigationBarItem(
                      label: "Forum",
                      icon: Icon(Icons.forum),
                      backgroundColor: kNavBarIcon,
                    ),
                    BottomNavigationBarItem(
                      label: "Profile",
                      icon: Icon(Icons.person),
                      backgroundColor: kNavBarIcon,
                    ),
                  ],
                ),
              ));
  }
}

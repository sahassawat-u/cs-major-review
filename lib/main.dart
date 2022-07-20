import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/models/api_uni_model.dart';
import 'package:cs_major_review/pages/profile_page.dart';

import 'package:cs_major_review/pages/university_page.dart';
import 'package:cs_major_review/pages/welcome_page.dart';
import 'package:cs_major_review/providers/firebase_provider.dart';
import 'package:cs_major_review/providers/geolocator_provider.dart';
import 'package:cs_major_review/providers/tags_provider.dart';
import 'package:cs_major_review/providers/unis_provider.dart';
import 'package:cs_major_review/providers/user_provider.dart';
import 'package:cs_major_review/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:cs_major_review/pages/forum_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TagProvider()),
      ChangeNotifierProvider(create: (_) => GeolocatorProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => UniProvider()),
      ChangeNotifierProvider(create: (_) => FirebaseProvider()),
    ],
    child: MyApp(
      firstPage: true,
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
  List<ApiUni> _unis = [];
  final screens = [
    UniversityPage(),
    ForumPage(),
    ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();
    context.read<GeolocatorProvider>().initGeo();
    context.read<FirebaseProvider>().initFirebase();
    getUnis();
  }

  void getUnis() async {
    ApiService apiService = ApiService();
    _unis = await apiService.getUnis() ?? [];
    context.read<UniProvider>().initUni(unis: _unis);
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

import 'dart:async';

import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/pages/edit_profile_page.dart';
// import 'package:cs_major_review/pages/edit_profile_page.dart';
import 'package:cs_major_review/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import '../providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _address = '';
  late String name;
  late int like;
  late int dislike;

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _getLocation() async {
    Position position = await locateUser();
    print(position);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    String address = ' ${place.locality}, ${place.country}';
    print(address);

    _address = address;
    setState(() {
      _address = address;
    });
  }

  FutureOr getNewState(dynamic value) {
    setState(() {
      name = context.read<UserProvider>().getUsername();
    });
  }

  @override
  void initState() {
    super.initState();
    locateUser();
    _getLocation();
    name = context.read<UserProvider>().getUsername();
    like = context.read<UserProvider>().getLike();
    dislike = context.read<UserProvider>().getDislike();
  }

  // String getAddress(double lat, double long) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IconButton(
                //   icon: Icon(Icons.arrow_back_outlined),
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                // ),
                // Text("Back")
                Text(
                  "My Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),

                Spacer(flex: 2),
                IconButton(
                    onPressed: () {
                      print(context.read<UserProvider>().getUsername());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage(
                                name:
                                    context.read<UserProvider>().getUsername(),
                                picture:
                                    context.read<UserProvider>().getPicture())),
                      ).then(getNewState);
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ProfilePicture(
                height_: 200,
                width_: 200,
                picture: context.read<UserProvider>().getPicture(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text("Forum Likes", style: TextStyle(fontSize: 15)),
                      Container(
                        child: Text(like.toString()),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    width: 60,
                    thickness: 1,
                    // indent: 20,
                    endIndent: 10,
                    color: kFontColor,
                  ),
                  Column(
                    children: [
                      Text("Forum Dislikes", style: TextStyle(fontSize: 15)),
                      Container(
                        child: Text(dislike.toString()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(name,
                  // context.read<UserProvider>().getUsername(),
                  style: TextStyle(fontSize: 15)),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Text(context.read<UserProvider>().getRole(),
                  style: TextStyle(fontSize: 15)),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              // child: TextButton(
              //     onPressed: () {getLocation(context.read<GeolocatorProvider>().getLat(),context.read<GeolocatorProvider>().getLong());  },
              //     child: Text("TEST"),),
              child: Text("Lives in $_address"),
            ),
          ],
        ),
      ),
    );
  }
}

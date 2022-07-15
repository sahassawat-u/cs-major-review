import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorProvider with ChangeNotifier {
  late LocationPermission permission;
  late double lat;
  late double long;
  void initGeo() async {
    permission = await Geolocator.requestPermission();
    bool serviceStatus = await Geolocator.isLocationServiceEnabled();

    if (permission != LocationPermission.deniedForever) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      lat = position.latitude;
      long = position.longitude;
      print(lat);
      print(long);
    }
  }

  double getLat() {
    return lat;
  }

  double getLong() {
    return long;
  }
}

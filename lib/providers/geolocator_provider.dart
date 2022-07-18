import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorProvider with ChangeNotifier {
  late LocationPermission permission;
  late Position position;
  // late double lat;
  // late double long;
  void initGeo() async {
    position = await _determinePosition();
    // permission = await Geolocator.requestPermission();
    // bool serviceStatus = await Geolocator.isLocationServiceEnabled();

    // if (permission != LocationPermission.deniedForever) {
    //   Position position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.best,
    //       forceAndroidLocationManager: true);
    //   lat = position.latitude;
    //   long = position.longitude;
    //   // print(lat);
    //   // print(long);
    // }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  double getLat() {
    return position.latitude;
  }

  double getLong() {
    return position.longitude;
  }
}

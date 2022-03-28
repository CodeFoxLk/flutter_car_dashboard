import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GeoLocationProvider extends ChangeNotifier {
  final MapController mapController = MapController();
  String speed = '0.00';
  Timer? _myLocationChecker;

  void initGeoLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      myLocationChecker();
      return Future.error('Location services are disabled.');
    }else if(_myLocationChecker != null) {
      _myLocationChecker?.cancel();
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

    final curruntPosition = await Geolocator.getCurrentPosition();
    updateMyLocation(curruntPosition);

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );

    resetSpeed();

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      updateMyLocation(position);
    });
  }

  // ****** some times the PositionStream won't be working when the movement stop, so has to manually zero the speed every 2 seconds
  void resetSpeed() {
    Timer.periodic(const Duration(milliseconds: 2000), (timer) async {
      speed = '0.00';
      notifyListeners();
    });
  }

  
  void myLocationChecker() async {
    _myLocationChecker = Timer.periodic(const Duration(milliseconds: 10000), (timer) async {
      final curruntPosition = await Geolocator.getCurrentPosition();
      updateMyLocation(curruntPosition);
      if(await Geolocator.isLocationServiceEnabled()) return _myLocationChecker?.cancel();
    });
  }

  void updateMyLocation(Position? curruntPosition) {
    if (curruntPosition == null) return;
    mapController.rotate(curruntPosition.heading);
    mapController.move(
        LatLng(curruntPosition.latitude, curruntPosition.longitude), 15);
    speed = (curruntPosition.speed * 3600 / 1000).abs().toStringAsFixed(2); // speed in KM/h
    notifyListeners();
  }
}

import 'package:geolocator/geolocator.dart';

class UserLocation {
  Future<bool> handleLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {   
        return false;
      }
    }
    return true;
  }
}
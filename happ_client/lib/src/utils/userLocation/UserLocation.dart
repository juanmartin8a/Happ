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
  // if (permission == LocationPermission.deniedForever) {
  //   // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //   //   content: Text('Location permissions are permanently denied, we cannot request permissions.')));
  //   return false;
  // }
  return true;
}
}
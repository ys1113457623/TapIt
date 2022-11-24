import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final longitude = 0.0.obs;
  final langitude = 0.0.obs;

  getLocation(Position p) {
    langitude.value = p.latitude;
    longitude.value = p.longitude;
  }
}

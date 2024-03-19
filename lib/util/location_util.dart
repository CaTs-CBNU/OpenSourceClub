import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationUtil {
  static Stream<Position>? _positionStream;

  static Future<Position> determinePosition() async {
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

    return await Geolocator.getCurrentPosition();
  }

  static Future<void> startPeriodicPositionUpdates() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      _positionStream = Stream.periodic(
        const Duration(seconds: 1),
        (count) async {
          try {
            return await getPosition();
          } catch (error) {
            print('Error getting position: $error');
            rethrow;
          }
        },
      ).asyncMap((event) => event);
    } else {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are denied');
      } else {
        await startPeriodicPositionUpdates();
      }
    }
  }

  static void stopPeriodicPositionUpdates() {
    _positionStream = null;
  }

  static Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  static Stream<Position>? getPositionStream() {
    return _positionStream;
  }

  static bool isInsideCircle(double currentLatitude, double currentLongitude) {
    double circleCenterLatitude = 36.626714032612476;
    double circleCenterLongitude = 127.45788940457949;
    double circleRadius = 18;

    double distance = Geolocator.distanceBetween(
      currentLatitude,
      currentLongitude,
      circleCenterLatitude,
      circleCenterLongitude,
    );

    if (distance <= circleRadius) {
      return true;
    } else {
      return false;
    }
  }
}

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static Future<void> requestLocationPermission() async {
    var locationState = await Permission.location.status;
    if (locationState.isDenied) {
      await Permission.location.request();
    }
    // 여러 요청 한번에 하도록 수정 -> 필요한 것들 권한들 생기면 수정하기
  }

  static Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}

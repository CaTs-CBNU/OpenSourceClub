import 'package:cats/util/location_util.dart';
import 'package:cats/util/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapViewModel extends ChangeNotifier {
  bool _disposed = false;
  LatLng? _latLng = LatLng(37.506502, 127.053617);
  LatLng? get latLng => _latLng;
  KakaoMapController? _controller;
  KakaoMapController? get controller => _controller;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  final List<Marker> _marker = [
    Marker(
      latLng: LatLng(37.506502, 127.053617),
      markerId: "userLocation",
      markerImageSrc:
          'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
    ),
  ];

  List<Marker>? get marker => _marker;

  void setLatLng(LatLng latLng) {
    _latLng = latLng;
    LoggerUtil.info("position setLatLng: $_latLng");

    notifyListeners();
  }

  void setMarker(List<Marker> marker) {
    _marker.addAll(marker);
    notifyListeners();
  }

  void setController(KakaoMapController controller) {
    _controller = controller;
    notifyListeners();
  }

  Future<void> updateLocation() async {
    // 위치 정보 가져오기
    Position position = await LocationUtil.determinePosition();
    LoggerUtil.info("position updateLocation: $position");
    Marker currentMarker = Marker(
      latLng: LatLng(position.latitude, position.longitude),
      markerId: "userLocation",
      markerImageSrc:
          'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
    );
    // 기존 유저 마커가 있는지 확인하고 업데이트 또는 추가
    int index =
        _marker.indexWhere((marker) => marker.markerId == "userLocation");
    if (index != -1) {
      // 기존 유저 마커가 있으면 업데이트
      _marker[index] = currentMarker;
    } else {
      // 기존 유저 마커가 없으면 추가
      _marker.add(currentMarker);
    }
    // ViewModel에 위치 업데이트
    setLatLng(
      LatLng(position.latitude, position.longitude),
    );
    controller!.panTo(
      LatLng(position.latitude, position.longitude),
    );
    notifyListeners();
  }
}

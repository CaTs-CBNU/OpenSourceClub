import 'package:cats/navigation/bottom_menu/map/view_model/map_view_model.dart';
import 'package:cats/util/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapViewModel>(
      create: (_) => MapViewModel(),
      child: const MapViewContainer(),
    );
  }
}

class MapViewContainer extends StatelessWidget {
  const MapViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapViewModel>(
      builder: (context, viewModel, _) {
        // viewModel.startLocationUpdates();
        return Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: KakaoMap(
                center: viewModel.latLng!,
                markers: viewModel.marker!,
                mapTypeControl: true,
                zoomControl: true,
                onCenterChangeCallback: (latlng, zoomLevel) {
                  LoggerUtil.info("onCenterChangeCallback: $latlng");
                },
                onMapCreated: (controller) {
                  viewModel.setController(controller);
                },
              ),
            ),
            Positioned(
              bottom: 100.0,
              right: 20.0,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () async {
                  viewModel.updateLocation();
                },
                shape:
                    const CircleBorder(side: BorderSide(color: Colors.white)),
                child: const Icon(Icons.my_location),
              ),
            )
          ],
        );
      },
    );
  }
}

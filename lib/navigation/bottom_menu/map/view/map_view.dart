import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cats/navigation/bottom_menu/map/view_model/map_view_model.dart';
import 'package:cats/navigation/bottom_menu/search/view/search_view.dart';
import 'package:cats/navigation/bottom_menu/search/view_model/search_view_model.dart';
import 'package:cats/util/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

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
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(230, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10.0), // 모서리 둥글게 처리
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // 그림자 위치 조절
                      ),
                    ],
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 250.0,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        child: AnimatedTextKit(
                          pause: const Duration(milliseconds: 1000),
                          animatedTexts: [
                            FadeAnimatedText('장소를 검색하세요'),
                            FadeAnimatedText('장소를 검색하세요'),
                          ],
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                duration: const Duration(milliseconds: 400),
                                type: PageTransitionType.leftToRightWithFade,
                                child: ChangeNotifierProvider<SearchViewModel>(
                                  create: (_) => SearchViewModel(),
                                  child: const SearchView(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

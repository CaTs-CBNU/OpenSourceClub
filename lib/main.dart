import 'package:cats/util/app_key_util.dart';
import 'package:cats/util/go_router_util.dart';
import 'package:cats/util/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthRepository.initialize(appKey: AppKey.KAKAOMAP_JAVASCRIPT_KEY);
  // KakaoSdk.init(
  //     nativeAppKey: AppKey.KAKAOMAP_NATIVE_KEY,
  //     javaScriptAppKey: AppKey.KAKAOMAP_JAVASCRIPT_KEY); // 이 줄을 runApp 위에 추가한다.
  LoggerUtil.info("kakaosdk ${await KakaoSdk.origin}");
  runApp(const MyApp());
}

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouterUtil.router,
    );
  }
}

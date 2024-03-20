import 'package:cats/kakao/model/kakao_keyword_place_model.dart';
import 'package:cats/util/app_key_util.dart';
import 'package:cats/util/logger_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KakaoRestApi {
  static Future<List<KakaoKeywordPlaceModel>> searchKeywordPlace(
      {required String query}) async {
    var apiUrl = Uri.parse(
        'https://dapi.kakao.com/v2/local/search/keyword.json?query=$query');
    var response = await http.get(apiUrl,
        headers: {"Authorization": "KakaoAK ${AppKey.kakaoMapRestApiKey}"});
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<KakaoKeywordPlaceModel> placeList = [];

      for (var place in jsonResponse['documents']) {
        placeList.add(KakaoKeywordPlaceModel.fromJson(place));
        LoggerUtil.info('장소: $place');
      }
      return placeList;
    } else {
      LoggerUtil.debug('API 요청 실패: ${response.statusCode}');
      return [];
    }
  }
}


/*
메서드	URL	인증 방식 
GET	https://dapi.kakao.com/v2/local/search/category.${FORMAT}	REST API 키

이름	설명	필수 
Authorization	Authorization: KakaoAK ${REST_API_KEY}
인증 방식, REST API 키로 인증 요청	O
*/
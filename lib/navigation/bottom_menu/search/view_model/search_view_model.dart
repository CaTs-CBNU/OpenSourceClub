import 'package:cats/kakao/view_model/kakao_rest_api.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchViewModel extends ChangeNotifier {
  String startLocation = '';
  String endLocation = '';

  void setStartLocation(String location) {
    startLocation = location;
    notifyListeners();
  }

  void setEndLocation(String location) {
    endLocation = location;
    notifyListeners();
  }

  void searchModalBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 10, right: 10, bottom: 20),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    hintText: '장소를 입력하세요',
                    prefixIcon: Icon(
                      Icons.search,
                      size: 16,
                    ),
                  ),
                  onSubmitted: (value) {
                    KakaoRestApi.searchKeywordPlace(query: value);
                  },
                  onChanged: (value) {
                    // 사용자가 타이핑할 때마다 이벤트 발생
                    // value 매개변수에는 현재 텍스트 필드에 입력된 값이 포함됨
                    KakaoRestApi.searchKeywordPlace(query: value);
                  },
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text("장소결과"),
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}

import 'package:cats/entrance/model/login_data_model.dart';
import 'package:cats/util/permission_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends ChangeNotifier {
  LoginDataModel? _loginDataModel;
  String _email = '';
  String _password = '';

  LoginDataModel? get loginDataModel => _loginDataModel;

  void setLoginDataModel(LoginDataModel? loginDataModel) {
    _loginDataModel = loginDataModel;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void login(BuildContext context) async {
    // 위치 권한 확인
    bool hasLocationPermission = await PermissionUtil.checkLocationPermission();
    if (!hasLocationPermission) {
      // 위치 권한이 없는 경우 처리
      PermissionUtil.requestLocationPermission();
      // 예: 사용자에게 위치 권한을 요청하거나 알림을 표시
      return;
    }
    // 로그인 로직을 수행합니다. 여기에서는 간단히 입력된 이메일과 비밀번호를 출력합니다.
    // LoggerUtil.info('Email: $_email, Password: $_password');

    // 로그인 데이터 모델을 생성하고 설정합니다.
    setLoginDataModel(LoginDataModel(email: _email, password: _password));

    // 로그인 성공 시 '/home' 경로로 이동합니다.
    GoRouter.of(context).go('/home');
    // 위치 권한이 허용될 때까지 login 메서드를 반복 호출
  }
}

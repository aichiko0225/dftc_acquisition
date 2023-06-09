
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import 'app_state.dart';

/// 全局的单例。用于保存路由栈信息，或者其他全局数据
class Application {
  Application._internal(); // private constructor

  static final Application shared = Application._internal();

  static BuildContext? buildContext;

  final _state = AppState();

  AppState get appState {
    return _state;
  }

  setRememberPassword(bool rem) {
    _state.setRememberPassword(rem);
  }

  logout() {
    _state.logout();
    Get.offAllNamed(Routes.login);
  }

}
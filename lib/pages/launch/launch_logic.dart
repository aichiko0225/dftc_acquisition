import 'dart:io';

import 'package:dftc_acquisition/routes/routes.dart';
import 'package:get/get.dart';

import '../../states/application.dart';
import '../../utils/ssi_logger.dart';

class LaunchLogic extends GetxController {

  void userAgreementOnTap() {
    SsiLogger.d('《用户协议》');
    Get.toNamed(Routes.webview, arguments: {"title": "《用户协议》", "index": 1});
  }

  void privacyPolicyOnTap() {
    SsiLogger.d('《隐私政策》');
    Get.toNamed(Routes.webview, arguments: {"title": "《隐私政策》", "index": 2});
  }

  void agreeOnPressed() {
    //同意
    SsiLogger.d('同意并继续');
    setPrivacyAgreeStatus(true);
    // 分开处理，可能会有差异
    Get.offAllNamed(Routes.login);
  }

  void notAgreeOnPressed() {
    // 不同意，退出app
    exit(0);
  }

  void setPrivacyAgreeStatus(bool agree) {
    Application.shared.appState.setPrivacyAgreeStatus(agree);
  }

}

import 'package:dftc_acquisition/utils/ssi_logger.dart';
import 'package:get/get.dart';

import '../../services/index.dart';

class LoginLogic extends GetxController {

  var available = false.obs;

  var rememberPwd = false.obs;
  //是否显示密码
  var showPwd = false.obs;

  var userName = '';
  var password = '';
  var imageCode = '';

  var captchaImageText = ''.obs;

  @override
  onInit() {
    super.onInit();
    requestCaptchaImageData();
  }

  requestCaptchaImageData() async {
    var model = await LoginService.getCaptchaImage();
    SsiLogger.d(model.toJson());
    captchaImageText.value = model.img ?? '';
  }

  updatePhoneNum(String text) {
    userName = text;
    available.value = userName.isNotEmpty && password.isNotEmpty;
  }

  updatePassword(String text) {
    password = text;
    available.value = userName.isNotEmpty && password.isNotEmpty;
  }

  updateImageCode(String text) {
    imageCode = text;
  }

  updateShowPassword(bool show) {
    showPwd.value = show;
  }

}

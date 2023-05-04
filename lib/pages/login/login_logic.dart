import 'package:get/get.dart';

class LoginLogic extends GetxController {

  var available = false.obs;

  var rememberPwd = false.obs;
  //是否显示密码
  var showPwd = false.obs;

  var userName = '';
  var password = '';

  updatePhoneNum(String text) {
    userName = text;
    available.value = userName.isNotEmpty && password.isNotEmpty;
  }

  updatePassword(String text) {
    password = text;
    available.value = userName.isNotEmpty && password.isNotEmpty;
  }

  updateShowPassword(bool show) {
    showPwd.value = show;
  }

}

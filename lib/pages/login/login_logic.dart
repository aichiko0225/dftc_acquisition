import 'package:get/get.dart';

class LoginLogic extends GetxController {

  var available = false.obs;

  var phoneNum = '';

  updatePhoneNum(String text) {
    phoneNum = text;
    available.value = phoneNum.isPhoneNumber;
  }

}

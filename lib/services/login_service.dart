import 'package:ssi_service/ssi_service.dart';
import 'package:get/get.dart';
import '../models/login_model.dart';
import '../services/constants.dart';

class LoginService {

  static Future<CaptchaImageModel> getCaptchaImage() async {
    final requestClient = Get.find<RequestClient>();
    final response = await requestClient.get(LoginAPI.captchaImage);
    if (response.exception != null) {
      throw response.exception!;
    }
    var model = CaptchaImageModel.fromJson(response.data['data']);
    return model;
  }

}
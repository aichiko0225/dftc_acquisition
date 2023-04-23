import 'package:ssi_service/src/models/base_model.dart';
import 'package:ssi_service/src/request/client.dart';
import 'package:ssi_service/src/request/response.dart';

// 业务服务，单独创建
class CustomService {

  static Future<SsiResponse> getNone() async {
    final response = await RequestClient().get('url');
    return response;
  }

}
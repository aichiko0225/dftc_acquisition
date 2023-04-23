
import 'package:dio/dio.dart';
import 'package:ssi_service/src/request/exceptions.dart';
import 'package:ssi_service/src/request/response.dart';
import 'package:ssi_service/src/request/transformer.dart';

/// 默认的解析器，可以自定义
class DefaultHttpTransformer extends SsiTransformer {

  @override
  SsiResponse parse(Response response) {
    // 拦截所有statusCode 不为200的返回
    if (response.statusCode != 200) {
      var exception = HttpException(response.statusCode, response.statusMessage);
      return SsiResponse.error(exception);
    }
    return SsiResponse.completed(response.data);
  }

  /// 单例对象
  static final DefaultHttpTransformer _instance = DefaultHttpTransformer._internal();

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  DefaultHttpTransformer._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory DefaultHttpTransformer.getInstance() => _instance;
}
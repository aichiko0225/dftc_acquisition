import 'package:dio/dio.dart';

import 'response.dart';

abstract class SsiTransformer {
  SsiResponse parse(Response response);
}

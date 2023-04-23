

import 'package:dio/dio.dart';

import 'default_transformer.dart';
import 'exceptions.dart';
import 'response.dart';
import 'transformer.dart';

SsiResponse handleResponse(Response? response,
    {SsiTransformer? httpTransformer}) {
  httpTransformer ??= DefaultHttpTransformer.getInstance();
  // 返回值异常
  if (response == null) {
    return SsiResponse.failureFromError();
  }

  return httpTransformer.parse(response);
}

SsiResponse handleException(Exception error) {
  var parseException = _parseException(error);
  return SsiResponse.error(parseException);
}

HttpException _parseException(Exception error) {
  if (error is DioError) {
    return HttpException.create(error);
  } else {
    return UnknownException(error.toString());
  }
}
import 'package:dio/dio.dart';

/// dio 配置项
class HttpConfig {
  final String? baseUrl;
  final String? proxy;
  final String? cookiesPath;
  // 拦截器
  final List<Interceptor>? interceptors;
  // 超时设置
  final Duration connectTimeout;
  final Duration sendTimeout;
  final Duration receiveTimeout;

  // headers
  final Map<String, dynamic>? headers;

  HttpConfig({
    this.baseUrl,
    this.headers,
    this.proxy,
    this.cookiesPath,
    this.interceptors,
    this.connectTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
  });

// static DioConfig of() => Get.find<DioConfig>();
}
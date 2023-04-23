import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_channel/src/bridge_listener.dart';

import 'messages.dart';

class FlutterChannel {
  static const MethodChannel _channel = MethodChannel('flutter_channel');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

typedef EventListener = Future<dynamic>? Function(String key, Map arguments);

typedef ResponseCallback = Future<dynamic>? Function(Map arguments);

/// Flutter 桥接类
class FlutterBridge {
  static const MethodChannel _channel = MethodChannel('flutter_bridge');

  final BridgeListener _listener = BridgeListener();

  FlutterBridge._();

  ///The singleton for [FlutterBridge]
  static final FlutterBridge _instance = FlutterBridge._();

  static FlutterBridge get instance {
    return _instance;
  }

  /// Add event listener in flutter side, which is to listen
  /// the events from native side
  ///
  /// The [VoldCallBack] is to remove this listener
  VoidCallback addEventListener(String key, EventListener listener) {
    return _listener.addEventListener(key, listener);
  }

  callHandler(String methodName,
      {Map<String, dynamic>? params, ResponseCallback? responseCallback}) {
    CallMethodParams callMethodParams = CallMethodParams()
      ..methodName = methodName
      ..arguments = params;
    _listener.sendEventToNative(callMethodParams);
    
    ///声明一个用来存回调的对象
    _listener.addMethodCallbackListener(methodName, responseCallback);
  }
}

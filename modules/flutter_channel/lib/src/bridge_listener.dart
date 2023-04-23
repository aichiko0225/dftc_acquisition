// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flutter_bridge.dart';
import 'messages.dart';

/// 桥接的监听者
/// 用于保存app端注册的监听者事件
class BridgeListener {
  /// 用于监听事件的 message，只接收事件，不发送message
  final BasicMessageChannel<Object?> _channel =
      const BasicMessageChannel<Object?>(
          'flutter.sendEvent.listener', StandardMessageCodec());

  /// 给原生端发送事件的 channel
  final BasicMessageChannel<Object?> _nativeChannel =
      const BasicMessageChannel<Object?>(
          'flutter.sendEvent.native', StandardMessageCodec());

  /// Things about method channel
  /// 多个key 可能会存在多个页面的 Listener
  final Map<String, List<EventListener>> _listenersTable =
      <String, List<EventListener>>{};

  final Map<String, ResponseCallback?> _responseListenerMap =
      <String, ResponseCallback?>{};

  BridgeListener() {
    _channel.setMessageHandler((Object? message) async {
      assert(message != null, 'Argument was null. Expected CommonParams.');
      final CommonParams input = CommonParams.decode(message);
      onReceiveEventFromNative(input);
      return;
    });

    _nativeChannel.setMessageHandler((Object? message) async {
      assert(message != null, 'Argument was null. Expected ResponseParams.');
      final ResponseParams responseParams = ResponseParams.decode(message);
      onReceiveCallbackFromNative(responseParams);
      return;
    });
  }

  Future<void> sendEventToNative(CallMethodParams callMethodParams) async {
    final Object encoded = callMethodParams.encode();
    final Map? replyMap = await _nativeChannel.send(encoded) as Map?;
    
    if (replyMap == null) {
      // 如果原生没有反馈，则抛出异常
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object, dynamic> error =
          Map<Object, dynamic>.from(replyMap['error']);
      // 如果原生反馈出Error，则抛出异常信息
      throw PlatformException(
        code: (error['code'] as String),
        message: error['message'] as String,
        details: error['details'],
      );
    } else {
      // noop
    }
  }

  /// 收到原生发送的 回调事件
  void onReceiveCallbackFromNative(ResponseParams params) {
    var methodName = params.methodName ?? '';
    Map args = params.arguments ?? {};

    final callback = _responseListenerMap[methodName];

    if (callback != null) {
      callback(args);
    }
    // 回调完成移除callback

    if (methodName.isNotEmpty && callback != null) {
      _removeMethodCallback(methodName);
    }
  }

  /// Calls when Native send event to flutter(here)
  void onReceiveEventFromNative(CommonParams params) {
    //Get the name and args from native
    var key = params.key ?? '';
    Map args = params.arguments ?? {};
    assert(key != null);

    //Get all of listeners matching this key
    final listeners = _listenersTable[key];

    if (listeners == null) return;

    for (final listener in listeners) {
      listener(key, args);
    }
  }

  void addMethodCallbackListener(
      String methodName, ResponseCallback? listener) {
    assert(methodName != null && listener != null);

    if (listener != null) {
      _responseListenerMap[methodName] = listener;
    }
  }

  void _removeMethodCallback(String? methodName) {
    assert(methodName != null);
    var callback = _responseListenerMap[methodName];
    if (callback != null) {
      callback = null;
      _responseListenerMap.remove(methodName);
    }
  }

  /// Add event listener in flutter side with a [key] and [listener]
  VoidCallback addEventListener(String key, EventListener listener) {
    assert(key != null && listener != null);

    var listeners = _listenersTable[key];

    if (listeners == null) {
      listeners = [];
      _listenersTable[key] = listeners;
    }
    // listeners 添加监听者
    listeners.add(listener);

    return () {
      listeners?.remove(listener);
    };
  }
}

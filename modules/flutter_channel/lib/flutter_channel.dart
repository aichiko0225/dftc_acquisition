library flutter_channel;

export './src/flutter_bridge.dart';
export './src/bridge_listener.dart';
export './src/messages.dart';
export './src/native_view.dart';

/*
 * Flutter 与 Android iOS 原生的通信有以下三种方式
 * BasicMessageChannel 实现 Flutter 与 原生(Android 、iOS)双向通信
 * MethodChannel 实现 Flutter 与 原生原生(Android 、iOS)双向通信
 * EventChannel 实现 原生原生(Android 、iOS)向Flutter 发送消息 仅支持数据单向传递，无返回值。
 */
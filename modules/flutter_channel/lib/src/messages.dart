
// ignore_for_file: unnecessary_null_comparison

class CommonParams {

  Map<Object, Object?>? arguments;
  String? key;

  Object encode() {
    final Map<Object, Object?> pigeonMap = <Object, Object?>{};
    if (arguments != null) {
      pigeonMap['arguments'] = arguments ?? {};
    }
    pigeonMap['key'] = key ?? '';
    return pigeonMap;
  }

  static CommonParams decode(dynamic message) {
    var pigeonMap = message;
    assert(pigeonMap != null, 'pigeonMap was null');
    return CommonParams()
      ..arguments = Map<Object, Object?>.from(pigeonMap['arguments'])
      ..key = pigeonMap['key'] as String;
  }
}

class CallMethodParams {

  /// 方法参与
  Map<Object, Object?>? arguments;
  /// 方法名称
  String? methodName;
  /// 类名（iOS可以使用类名和方法名来发送消息来调用）
  String? className;


  Object encode() {
    final Map<Object, Object?> pigeonMap = <Object, Object?>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        pigeonMap[fieldName] = value;
      }
    }
    pigeonMap['methodName'] = methodName ?? '';

    addIfPresent('arguments', arguments);
    addIfPresent('className', className);

    return pigeonMap;
  }

  static CallMethodParams decode(dynamic message) {
    var pigeonMap = message;
    assert(pigeonMap != null, 'pigeonMap was null');
    return CallMethodParams()
      ..arguments = Map<Object, Object?>.from(pigeonMap['arguments'])
      ..methodName = pigeonMap['methodName'] as String?;
  }
}

class ResponseParams {

  Map<Object, Object?>? arguments;
  String? methodName;

  Object encode() {
    final Map<Object, Object?> pigeonMap = <Object, Object?>{};
    if (arguments != null) {
      pigeonMap['arguments'] = arguments ?? {};
    }
    pigeonMap['methodName'] = methodName ?? '';
    return pigeonMap;
  }

  static ResponseParams decode(dynamic message) {
    var pigeonMap = message;
    assert(pigeonMap != null, 'pigeonMap was null');
    return ResponseParams()
      ..arguments = Map<Object, Object?>.from(pigeonMap['arguments'])
      ..methodName = pigeonMap['methodName'] as String?;
  }
}
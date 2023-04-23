import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

const String platformView_viewType = 'native_platform_view';

/// Flutter 原生视图的封装
/// 可以用数据动态构建
/// 暂时只实现iOS
class DFNativeView extends StatefulWidget {

  /// view name to be embedded by this widget.
  final String viewName;

  /// This can be used by plugins to pass constructor parameters to the embedded view.
  Map<String, dynamic>? creationParams;

  /// Container 的包含对象，一般为json字符串
  final dynamic jsonObject;

  final PlatformViewCreatedCallback? onPlatformViewCreated;

  DFNativeView(this.viewName, {Key? key, Map<String, dynamic>? creationParams, this.jsonObject, this.onPlatformViewCreated}) : super(key: key) {
    if (creationParams == null) {
      this.creationParams = <String, dynamic>{};
    }
    assert(viewName.isNotEmpty, 'viewName 不可为空');

    this.creationParams?['viewName'] = viewName;

    if (jsonObject != null) {
      this.creationParams?['jsonObject'] = jsonObject;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _DFNativeViewState();
  }
}

class _DFNativeViewState extends State<DFNativeView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return UiKitView(
        viewType: platformView_viewType,
        creationParams: widget.creationParams,
        onPlatformViewCreated: widget.onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (Platform.isAndroid) {
      return AndroidView(
        viewType: platformView_viewType,
        onPlatformViewCreated: widget.onPlatformViewCreated,
        creationParams: widget.creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Container(
      width: 100,
      height: 100,
      child: const Text('暂时不支持该平台视图'),
    );
  }

}

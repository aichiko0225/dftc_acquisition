import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_channel/flutter_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  Map _callbackMap = {};

  ///声明一个用来存回调的对象
  VoidCallback? removeListener;

  @override
  void dispose() {
    super.dispose();
    removeListener?.call();
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();

    removeListener =
        FlutterBridge.instance.addEventListener('key', (key, arguments) {
      debugPrint('EventListener: $key');
      return;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await FlutterChannel.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    const jsonStr = '''
    {
      "container": {
        "unitName": "Container",
        "children": [
          {
            "unitName": "text",
            "value": "iOS原生页面"
          }
        ]
      }
    }
    ''';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Running on: $_platformVersion\n'),
            Container(
              height: 40,
              child: const Text('点击浮动按钮之后 3秒后回调执行。'),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text('methodName: methodName on: $_callbackMap\n'),
            ),
            Container(
              height: 100,
              width: 100,
              child: DFNativeView(
                'viewName',
                jsonObject: jsonStr,
              ),
            )
          ],
        )),
        floatingActionButton: IconButton(
            onPressed: () {
              // 调用原生方法
              FlutterBridge.instance.callHandler('methodName', params: {},
                  responseCallback: (map) {
                // 设置回调
                setState(() {
                  _callbackMap = Map.from(map);
                });
              });
            },
            icon: const Icon(Icons.ac_unit_outlined)),
      ),
    );
  }
}

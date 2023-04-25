import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';

import '../utils/ssi_logger.dart';

class WebViewPage extends StatefulWidget {
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  final WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    dynamic arguments = Get.arguments;
    SsiLogger.d(arguments);
    var title = '用户协议';
    var index = 1;
    if (arguments != null) {
      title = arguments['title'] ?? '用户协议';
      index = int.parse(arguments['index'].toString());
    }
    _loadHtmlFromAssets(index);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: BackButton(
          onPressed: () async {
            bool canGoBack = await _webViewController.canGoBack();
            if (canGoBack) {
              await _webViewController.goBack();
            } else {
              Get.back();
            }
          },
        ),
        // actions: [],
      ),
      body: WebViewWidget(
        controller: _webViewController,
        // onWebViewCreated: (webViewController) {
        //   // SsiLogger.d(webViewController);
        //   _webViewController = webViewController;
        //   _loadHtmlFromAssets(index);
        // },
      ),
    );
  }

  _loadHtmlFromAssets(int index) async {
    String filePath = 'statics/html/$index.html';

    String fileHtmlContents = await rootBundle.loadString(filePath);
    _webViewController.loadHtmlString(fileHtmlContents);
  }

}

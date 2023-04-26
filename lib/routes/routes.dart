import 'package:dftc_acquisition/pages/launch/launch_page.dart';
import 'package:dftc_acquisition/pages/login/login_view.dart';
import 'package:dftc_acquisition/pages/questionnaire/introduce/introduce_page.dart' as M18;
import 'package:dftc_acquisition/pages/questionnaire/questionnaire_view.dart';
import 'package:dftc_acquisition/pages/tabbar/tabbar_view.dart';
import 'package:dftc_acquisition/pages/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home/home_view.dart';

class Routes {
  /// 主页面
  static String root = '/';

  static String home = '/home';

  static String launch = '/launch';

  /// 调查问卷
  static String questionnaire = '/grid/questionnaire';
  static String m18_introduce = '/m18/introduce';

  /// web页面
  static String webview = '/webview';

  /// 登录页面
  static String login = '/login';

  /// 选择车辆
  /// arguments 示例 { "showType": 0, "title": "导航栏标题" }
  /// [showType] 0-3 代表显示的车辆类型 0 全部 1 行驶中 2 停止 3 离线
  static String selectVehicle = '/select/vehicles';

  static Map<String, Widget Function(BuildContext)> routesMap = {
    root: (context) => TabbarPage(),
    home: (context) => HomePage(),
    questionnaire: (context) => QuestionnairePage(),
    login: (context) => LoginPage(),
    launch: (context) => LaunchPage(),
    webview: (context) => WebViewPage(),
    m18_introduce: (context) => M18.IntroducePage(),
  };

  /// 别名映射页面
  static final List<GetPage> getPages = [
    GetPage(
        name: root, page: () => TabbarPage(), transition: Transition.fadeIn),
    GetPage(name: login, page: () => LoginPage(), transition: Transition.fadeIn),
    GetPage(name: launch, page: () => LaunchPage(), transition: Transition.fadeIn),
    GetPage(name: home, page: () => HomePage(), transition: Transition.native),
    GetPage(name: m18_introduce, page: () => M18.IntroducePage(), transition: Transition.native),
    GetPage(name: webview, page: () => WebViewPage(), transition: Transition.native),
    GetPage(
        name: questionnaire,
        page: () => QuestionnairePage(),
        transition: Transition.cupertino),
  ];
}

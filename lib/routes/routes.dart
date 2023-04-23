import 'package:dftc_acquisition/pages/tabbar/tabbar_view.dart';
import 'package:get/get.dart';

import '../pages/home/home_view.dart';

class Routes {
  /// 主页面
  static String root = '/';

  /// 启动页面 （ 显示隐私政策的弹框，不同意则无法进入app ）
  static String launch = '/launch';

  /// web页面
  static String webview = '/webview';

  /// 登录页面
  static String login = '/login';

  /// 选择车辆
  /// arguments 示例 { "showType": 0, "title": "导航栏标题" }
  /// [showType] 0-3 代表显示的车辆类型 0 全部 1 行驶中 2 停止 3 离线
  static String selectVehicle = '/select/vehicles';

  /// 别名映射页面
  static final List<GetPage> getPages = [
    GetPage(name: root, page: () => TabbarPage(), transition: Transition.fadeIn),
  ];
}
import 'package:dftc_acquisition/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import './pages/tabbar/tabbar_view.dart';
import 'config/theme_config.dart';
import 'states/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ThemeConfig config = ThemeConfig.defaultConfig;
  Get.put<ThemeConfig>(config);

  // await Application.shared.appState.clearAllData();
  await Application.shared.appState.readSharedPreferencesData();

  runApp(SsiApp());
}

class SsiApp extends StatelessWidget {
  SsiApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isWeb) {
      return GetMaterialApp(
          navigatorKey: _navigatorKey,
          initialRoute: Routes.m18_introduce,
          getPages: Routes.getPages,
          routes: Routes.routesMap,
          builder: (context, widget) {
            return FlutterEasyLoading(
              child: widget,
            );
          });
    }
    return GetMaterialApp(
        navigatorKey: _navigatorKey,
        initialRoute: Routes.m18_introduce,
        getPages: Routes.getPages,
        routes: Routes.routesMap,
        builder: (context, widget) {
          return FlutterEasyLoading(
            child: widget,
          );
        });
  }
}

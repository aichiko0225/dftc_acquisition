import 'package:dftc_acquisition/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import './pages/tabbar/tabbar_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(SsiApp());
}

class SsiApp extends StatelessWidget {
  SsiApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: _navigatorKey,
        initialRoute: Routes.root,
        getPages: Routes.getPages,
        routes: Routes.routesMap,
        builder: (context, widget) {
          return FlutterEasyLoading(
            child: widget,
          );
        });
  }
}

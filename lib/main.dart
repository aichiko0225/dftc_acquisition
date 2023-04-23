import 'package:dftc_acquisition/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import './pages/tabbar/tabbar_view.dart';

Future<void> main() async {
  runApp(const SsiApp());
}

class SsiApp extends StatelessWidget {
  const SsiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: Routes.root,
        getPages: Routes.getPages,
        builder: (context, widget) {
          var root = TabbarPage();
          return FlutterEasyLoading(
            child: root,
          );
          // return home;
        });
  }
}

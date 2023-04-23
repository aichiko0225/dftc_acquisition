import 'package:dftc_acquisition/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: _gridView())],
        ),
      ),
    );
  }

  Widget _gridView() {
    return GridView(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        TextButton.icon(
            onPressed: () {
              Get.toNamed(Routes.questionnaire);
              // Navigator.of(context).pushNamed(Routes.questionnaire);
            },
            icon: Icon(Icons.access_alarms),
            label: Text('调查问卷')),
        TextButton.icon(
            onPressed: () {
              Get.toNamed(Routes.questionnaire);
            }, icon: Icon(Icons.adb), label: Text('调查问卷')),
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<HomeLogic>();
    super.dispose();
  }
}

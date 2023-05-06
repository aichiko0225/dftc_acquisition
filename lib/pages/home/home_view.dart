import 'package:dftc_acquisition/routes/routes.dart';
import 'package:dftc_acquisition/states/application.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bruno/bruno.dart';

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
        actions: [
          TextButton(onPressed: (){
            BrnDialogManager.showConfirmDialog(context,
                cancel: '取消',
                confirm: '确定',
                message: "是否确认退出登录",
                onConfirm: () {
                  // BrnToast.show("确定", context);
                  Application.shared.logout();
                },
                onCancel: () {
                  Navigator.pop(context);
                });
          }, child: Text('退出登录', style: TextStyle(color: Colors.white),))
        ],
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
              Get.toNamed(Routes.m18_introduce);
              // Navigator.of(context).pushNamed(Routes.questionnaire);
            },
            icon: Icon(Icons.access_alarms),
            label: Text('M18拉练')),
        TextButton.icon(
            onPressed: () {
              Get.toNamed(Routes.questionnaire);
            },
            icon: Icon(Icons.adb),
            label: Text('调查问卷')),
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<HomeLogic>();
    super.dispose();
  }
}

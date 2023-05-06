import 'package:bruno/bruno.dart';
import 'package:dftc_acquisition/config/theme_config.dart';
import 'package:dftc_acquisition/pages/evaluation_details/evaluationt_forms.dart';
import 'package:dftc_acquisition/pages/evaluation_details/scene_particulars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/extensions.dart';
import 'evaluation_details_logic.dart';

class EvaluationDetailsPage extends StatefulWidget {
  const EvaluationDetailsPage({super.key});

  @override
  State<EvaluationDetailsPage> createState() => _EvaluationDetailsPageState();
}

class _EvaluationDetailsPageState extends State<EvaluationDetailsPage> {
  final logic = Get.put(EvaluationDetailsLogic());
  final themeConfig = Get.find<ThemeConfig>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  _showSceneTipViewDialog() {
    showDialog(context: context, builder: (context) {
      return SceneParticularsPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '评价详情',
          style: DFTextStyle.titleStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(context: context, builder: (_) => _buildDialog());
              },
              icon: Icon(Icons.menu_outlined))
        ],
      ),
      body: Column(
        children: [_headerView(), _evaluationtFormsPageView()],
      ),
      backgroundColor: themeConfig.fillBody,
    );
  }

  Widget _headerView() {
    return Container(
      height: 40,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black26, offset: Offset(2.0, 2.0), blurRadius: 5.0)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '场景名称：名称可变',
              style: TextStyle(
                  color: themeConfig.colorTextHint,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          InkWell(
              onTap: () {
                BrnToast.show('显示场景提示', context);
                _showSceneTipViewDialog();
              },
              child: Container(
                  width: 60, child: Icon(Icons.question_mark_outlined))),
        ],
      ),
    );
  }

  Widget _evaluationtFormsPageView() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: PageView.builder(
            itemCount: 5,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return EvaluationtForms();
            }),
      ),
    );
  }

  //弹窗
  Widget _buildDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text('场景一'),
      titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
      titlePadding: EdgeInsets.only(top: 5, left: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      backgroundColor: Colors.white,
      content: _aaa(context),
      actions: [
        TextButton(
          child: Text("提交"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor: MaterialStateProperty.all(Colors.white)),
          onPressed: () {},
        ),
      ],
    );
  }

  //
  Widget _aaa(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      alignment: WrapAlignment.center,
      children: <Widget>[
        Chip(label: Text('1')),
        Chip(label: Text('2')),
        Chip(label: Text('3')),
        Chip(label: Text('4')),
        Chip(label: Text('5')),
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<EvaluationDetailsLogic>();
    super.dispose();
  }
}

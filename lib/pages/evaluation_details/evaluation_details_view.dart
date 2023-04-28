import 'package:bruno/bruno.dart';
import 'package:dftc_acquisition/config/theme_config.dart';
import 'package:dftc_acquisition/pages/evaluation_details/evaluationt_forms.dart';
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
                BrnToast.show('显示评价回答情况', context);
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
            itemBuilder: (context, index) {
              return EvaluationtForms();
            }),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<EvaluationDetailsLogic>();
    super.dispose();
  }
}

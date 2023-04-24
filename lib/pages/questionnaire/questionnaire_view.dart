import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'questionnaire_logic.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final logic = Get.put(QuestionnaireLogic());
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // EasyLoading.showSuccess('99999');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('问卷'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: _vehicleTitle(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: _vehicleInfoView(),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: _plateNumber()),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: _typeInquiryTitle()),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: _typeInquiry()),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: _vehicleScene()),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: _scene()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<QuestionnaireLogic>();
    super.dispose();
  }

  //车辆信息
  Widget _vehicleTitle() {
    return BrnCommonCardTitle(
      title: '车辆信息',
      accessoryWidget: Icon(Icons.qr_code_scanner_outlined),
    );
  }

  //车辆型号
  Widget _vehicleInfoView() {
    return BrnTextInputFormItem(
      title: "车辆型号",
      isRequire: true,
      hint: "请选择",
    );
  }

  //车牌号
  Widget _plateNumber() {
    return BrnTextInputFormItem(
      title: "车牌号",
      isRequire: true,
      hint: "请输入车牌号",
    );
  }

  //调查类型
  Widget _typeInquiryTitle() {
    return BrnCommonCardTitle(
      title: '调查类型',
    );
  }

  //车牌号
  Widget _typeInquiry() {
    return BrnTextInputFormItem(
      title: "调查类型",
      isRequire: true,
      hint: '请选择',
    );
  }

  //车辆场景
  Widget _vehicleScene() {
    return BrnCommonCardTitle(
      title: '车辆场景',
    );
  }

  //场景图片
  Widget _scene() {
    return Expanded(
      child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 4
      ), itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 150,
          height: 150,
          color: Colors.red,
        );
      },
      ),
    );
  }
}

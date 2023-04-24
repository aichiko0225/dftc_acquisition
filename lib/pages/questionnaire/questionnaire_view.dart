import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'questionnaire_logic.dart';

enum _PickerType {
  vehicle,
  inquiry
}

/// 问卷调查开始选择页面
class QuestionnairePage extends StatefulWidget {
  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final logic = Get.put(QuestionnaireLogic());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // 事件处理
  showSelectItemPickerView(_PickerType type) {
    if (type == _PickerType.vehicle) {
      BrnMultiDataPicker(
        context: context,
        title: '来源',
        delegate: Brn1RowDelegate(firstSelectedIndex: 1),
        confirmClick: (list) {
          BrnToast.show(list.toString(), context);
        },
      ).show();
    } else if (type == _PickerType.inquiry) {

    }
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
              padding: EdgeInsets.only(left: 10, right: 10), child: _scene()),
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
    return BrnTextSelectFormItem(
      title: "车辆型号",
      isRequire: true,
      hint: "请选择",
      onTap: () {
        showSelectItemPickerView(_PickerType.vehicle);
      },
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
    return BrnTextSelectFormItem(
      title: "调查类型",
      isRequire: true,
      hint: '请选择',
      onTap: () {
        showSelectItemPickerView(_PickerType.vehicle);
      },
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
    return GetBuilder<QuestionnaireLogic>(builder: (logic) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 350,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              crossAxisCount: 2,
              childAspectRatio: 1),
          itemCount: logic.sceneDataArr.length,
          itemBuilder: (BuildContext context, int index) {
            return _gridItemView(index);
          },
        ),
      );
    });
  }

  Widget _gridItemView(int index) {
    var text = logic.sceneDataArr[index];
    var selected = logic.selectIndexArr.contains(index);
    return GestureDetector(
      onTap: () {
        logic.selectSceneItem(index);
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.red),
        child: Stack(
          children: [
            Positioned(
              child: Image(
                  image: AssetImage('./images/aaa.png'), fit: BoxFit.fill),
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
            ),
            Positioned(
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
              bottom: 20,
              left: 12,
              right: 12,
            ),
            selected
                ? Positioned(
                right: 20,
                top: 5,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.blueAccent,
                ),
                width: 36,
                height: 36)
                : Container()
          ],
        ),
      ),
    );
  }
}

import 'package:bruno/bruno.dart';
import 'package:dftc_acquisition/components/delegate/picker_delegate.dart';
import 'package:dftc_acquisition/utils/ssi_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import 'questionnaire_logic.dart';

enum _PickerType { vehicle, inquiry }

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
    } else if (type == _PickerType.inquiry) {
      BrnMultiDataPicker(
        context: context,
        title: '调查类型',
        delegate: SingleTextRowDelegate(textList: ['体验评价', '故障问题录入']),
        confirmClick: (list) {
          var arr = list.map((e) => e as int);
          var index = arr.first;
          var text = ['体验评价', '故障问题录入'][index];
          logic.updateInquiryText(text);
        },
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('问卷'),
      ),
      body: ListView(
          shrinkWrap: true,
          children: [
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
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: _buttonView()),
          ],
        ),
    );
  }

  @override
  void dispose() {
    Get.delete<QuestionnaireLogic>();
    super.dispose();
  }

  //调查类型
  Widget _typeInquiryTitle() {
    return BrnCommonCardTitle(
      title: '调查类型',
    );
  }

  //车牌号
  Widget _typeInquiry() {
    return Obx(() {
      return BrnTextSelectFormItem(
        title: "调查类型",
        isRequire: true,
        hint: logic.inquiryText.value.isNotEmpty
            ? logic.inquiryText.value
            : '请选择',
        onTap: () {
          showSelectItemPickerView(_PickerType.inquiry);
        },
      );
    });
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
        child: GridView.builder(
          shrinkWrap: true,
            primary: false,
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

  //
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
                  image: AssetImage('./statics/images/aaa.png'),
                  fit: BoxFit.fill),
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

  //下一步
  Widget _buttonView() {
    return Container(
      height: 66,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextButton(
        child: Text("下一步"),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: () {
          Get.toNamed(Routes.evaluation_details);
        },
      ),
    );
  }
}

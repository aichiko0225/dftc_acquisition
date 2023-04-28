import 'package:bruno/bruno.dart';

import 'package:flutter/material.dart';

import '../../components/score_select.dart';
import '../../components/image_picker/image_video_picker.dart';

class EvaluationtForms extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EvaluationtFormsState();
  }
}

class _EvaluationtFormsState extends State<EvaluationtForms> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        children: [
          BrnBaseTitle(
            title:'远程控制车辆',
            subTitle: '接近车辆，迎宾灯光开启，评论感知',
          ),
          BrnTextSelectFormItem(
            title: '远程开启空调、车窗、天窗等功能',
            isRequire: true,
            hint: '选择评分',
          ),
          ScoreSelect(),
          _spaceView(),
          BrnTitleFormItem(title: '评分描述',),
          BrnInputText(
            maxLength: 100,
            padding: EdgeInsets.only(left: 20, right: 20, top: 8),
            maxHeight: 100,
          ),
          _spaceView(),
          BrnTitleFormItem(title: '描述（图片）',),
          ImagePickerView(controller: ImagePickerController(maxCount: 6)),
          BrnTitleFormItem(title: '描述（视频）',),
          VideoPickerView(controller: VideoPickerController())
        ],
      ),
    );
  }

  Widget _spaceView() {
    return Container(
      height: 20,
    );
  }

}
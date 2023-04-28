import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

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
        shrinkWrap: true,
        children: [
          BrnBaseTitle(
            title:'远程控制车辆',
            subTitle: '接近车辆，迎宾灯光开启，评论感知',
          )
        ],
      ),
    );
  }

}
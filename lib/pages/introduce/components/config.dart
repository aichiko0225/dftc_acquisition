import 'package:bruno/bruno.dart';
import 'package:dftc_acquisition/pages/introduce/components/config_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme_config.dart';

/// 介绍页面中的配置部分
class IntroduceConfigView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroduceConfigViewState();
  }
}

class _IntroduceConfigViewState extends State<IntroduceConfigView> {
  final themeConfig = Get.find<ThemeConfig>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  _vehicleListView(),
                  _recordsListView(),
                ],
              ),
            ),
            Positioned(right: 20, bottom: 20, child: _floatButtonView())
          ],
        ),
      ),
    );
  }

  // 车辆配置列表
  Widget _vehicleListView() {
    return Column(
      children: [
        Container(
          height: 20,
        ),
        BrnBaseTitle(
          title: '车辆配置',
        ),
        _buildLineView(),
        BrnTextInputFormItem(title: '车辆编号', hint: '车辆VIN',isEdit: false,),
        _buildLineView(),
        BrnTextInputFormItem(title: '车辆编号', hint: '车辆VIN',isEdit: false,),
        _buildLineView(),
        BrnTextInputFormItem(title: '车辆编号', hint: '车辆VIN',isEdit: false,),
        _buildLineView(),
        BrnTextInputFormItem(title: '车辆编号', hint: '车辆VIN',isEdit: false,),
        _buildLineView(),
        BrnTextInputFormItem(title: '车辆编号', hint: '车辆VIN',isEdit: false,),
        _buildLineView(),
        BrnTextInputFormItem(title: '车辆编号', hint: '车辆VIN',isEdit: false,),
        _buildLineView(),
      ],
    );
  }

  // 配置事项列表
  Widget _recordsListView() {
    return Column(children: [
      Container(
        height: 20,
      ),
      BrnBaseTitle(
        title: '配置事项',
      ),
      _buildLineView(),
      BrnTextInputFormItem(title: '配置事项类型', hint: '配置事项文本',isEdit: false,),
    ]);
  }

  // 配置按钮
  Widget _floatButtonView() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: IconButton(
        icon: Icon(
          Icons.add_circle_outline,
          color: themeConfig.brandPrimary,
          size: 36,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              enableDrag: false,
              backgroundColor: Colors.transparent,
              builder: (context) => ConfigBottomView(add: true, parentContext: context,));
        },
      ),
    );
  }

  Widget _buildLineView(
      {double? height = 1,
      double? indent = 15,
      double? endIndent = 15,
      Color? color = const Color(0xFFF0F0F0)}) {
    return Divider(
      height: height,
      indent: indent,
      endIndent: endIndent,
      color: color,
    );
  }
}

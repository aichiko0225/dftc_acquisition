import 'package:bruno/bruno.dart';
import 'package:dftc_acquisition/pages/introduce/components/config_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 介绍页面中的配置部分
class IntroduceConfigView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroduceConfigViewState();
  }
}

class _IntroduceConfigViewState extends State<IntroduceConfigView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _recordsListView(),
            Positioned(right: 20, bottom: 20, child: _floatButtonView())
          ],
        ),
      ),
    );
  }

  // 记录列表
  Widget _recordsListView() {
    return Container(
      child: ListView(
        children: [],
      ),
    );
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
        icon: Icon(Icons.settings_outlined),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              enableDrag: false,
              backgroundColor: Colors.transparent,
              builder: ConfigBottomView.buildWidget);
        },
      ),
    );
  }


}

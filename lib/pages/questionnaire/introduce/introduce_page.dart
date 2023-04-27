import 'package:bruno/bruno.dart';
import 'package:dftc_acquisition/config/extensions.dart';
import 'package:dftc_acquisition/pages/questionnaire/introduce/introduce_components.dart';
import 'package:dftc_acquisition/pages/questionnaire/introduce/introduce_logic.dart';
import 'package:dftc_acquisition/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme_config.dart';

// M18 拉练页面介绍页面
class IntroducePage extends StatefulWidget {
  const IntroducePage({Key? key}) : super(key: key);

  @override
  _IntroducePageState createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage>
    with SingleTickerProviderStateMixin {
  final themeConfig = Get.find<ThemeConfig>();
  final logic = Get.put(IntroduceLogic());

  var tabs = <BadgeTab>[];
  late TabController _tabController;

  final PageController _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabs.add(BadgeTab(text: "介绍"));
    tabs.add(BadgeTab(text: "评价"));
    tabs.add(BadgeTab(text: "分析"));
    tabs.add(BadgeTab(text: "配置"));
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeConfig.fillBody,
      appBar: AppBar(
        title: Text(
          'M18 拉练',
          style: DFTextStyle.titleStyle,
        ),
      ),
      body: Container(
          child: Column(
        children: [
          _tabbarView(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _tabController.index = index;
              },
              children: [
                _businessIntroView(),
                _evaluateView(),
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.purple,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  //介绍
  Widget _businessIntroView() {
    return BusinessIntroduceView(themeConfig: themeConfig);
  }

  //
  Widget _tabbarView() {
    return BrnTabBar(
      controller: _tabController,
      tabs: tabs,
      onTap: (state, index) {
        _pageController.jumpToPage(index);
      },
    );
  }

  //评价
  Widget _evaluateView() {
    return EvaluateView();
  }

}

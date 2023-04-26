import 'package:bruno/bruno.dart';
import 'package:dftc_acquisition/config/extensions.dart';
import 'package:dftc_acquisition/pages/questionnaire/introduce/introduce_evaluate.dart';
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

  var tabs = <BadgeTab>[];
  late TabController _tabController;

  final PageController _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabs.add(BadgeTab(text: "整体介绍"));
    tabs.add(BadgeTab(text: "试驾评价"));
    tabs.add(BadgeTab(text: "汇总分析"));
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                _evaluate(),
                Container(
                  color: Colors.green,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget _businessIntroView() {
    var personArr = [
      '王洛然',
      '陈志华',
      '刘佳明',
      '老万已',
      '催大学',
      '催大帅',
      '催小帅',
    ];
    return Container(
      color: themeConfig.fillBody,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 文本描述
            Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'M18业务介绍',
                      style: TextStyle(
                          color: themeConfig.colorTextBase,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'M18拉练通过记录驾乘人员拉练感受，并对评价的结果做出分析，进而汇总天气、海拔、车型等客观因素对拉练结果的影响',
                      style: TextStyle(
                        color: themeConfig.colorTextBase,
                        fontSize: 14,
                      ),
                    )
                  ],
                )),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                child: Image(image: AssetImage('./statics/images/ditu.png'))),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'M18人员介绍',
                    style: TextStyle(
                        color: themeConfig.colorTextBase,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      height: 300,
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              crossAxisCount: 4),
                          itemCount: personArr.length,
                          itemBuilder: (contex, index) {
                            Widget avatar = Image.asset(
                                "./statics/assets/images/profilephoto.png",
                                width: 60.0);
                            var name = personArr[index];
                            return Container(
                              height: 80,
                              child: Column(
                                children: [
                                  ClipOval(child: avatar),
                                  Text(name)
                                ],
                              ),
                            );
                          }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  //
  Widget _evaluate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 200,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 30,
            crossAxisSpacing: 4,
            childAspectRatio: 1),
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return _imageEvaluate();
        },
      ),
    );
  }

  //
  Widget _imageEvaluate() {
    return GestureDetector(
      onTap: (){
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => IntroduceEvaluate()));
      },
      child: Stack(
        children: [
          Positioned(
            child: Image(
                image: AssetImage('./statics/images/aaa.png'),
                fit: BoxFit.fill),
            width: 100,
            height: 100,
          ),
          Positioned(
            child: Text(
              'sss',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

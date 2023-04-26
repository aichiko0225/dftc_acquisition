import 'package:bruno/bruno.dart';
import 'package:dftc_acquisition/config/extensions.dart';
import 'package:flutter/material.dart';

// M18 拉练页面介绍页面
class IntroducePage extends StatefulWidget {
  const IntroducePage({Key? key}) : super(key: key);

  @override
  _IntroducePageState createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage>
    with SingleTickerProviderStateMixin {
  var tabs = <BadgeTab>[];
  late TabController _tabController;

  PageController _pageController = PageController();

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
                  Container(color: Colors.red,),
                  _evaluate(),
                  Container(color: Colors.green,),
                ],
              ),
            )
          ],
        )
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
Widget _evaluate(){
    return Container(
      height: 200,
      child: GridView.count(crossAxisCount: 4,
        children: [Icon(Icons.dangerous),Text('data')],
      ),
    );
}
}

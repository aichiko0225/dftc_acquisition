import 'package:dftc_acquisition/pages/home/home_view.dart';
import 'package:flutter/material.dart';

import '../../models/tabbar_item.dart';


class TabbarPage extends StatefulWidget {
  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  int _currentIndex = 0; //记录当前选中哪个页面

  //声明PageController
  PageController _pageController = PageController();

  late List<TabBarItemData> _itemDataList;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _itemDataList = [
      TabBarItemData(title: '首页1', builder: (context)=> HomePage() ),
      TabBarItemData(title: '首页2', builder: (context)=> HomePage() ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var _pageList = _itemDataList.map((e) => e.builder(context)).toList();

    var _buildItems = _itemDataList
        .map((item) => BottomNavigationBarItem(
      icon: item.icon ?? Container(),
      activeIcon: item.activeIcon,
      label: item.title,
    ))
        .toList();

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), //禁止滑动
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedItemColor: const Color(0xff9b9d9d),
        currentIndex: _currentIndex,
        //配置对应的索引值选中/icon大小
        type: BottomNavigationBarType.fixed,
        //配置底部tabs可以有多个按钮
        items: _buildItems,
        onTap: (index) {
          setState(() {
            //第4步，设置点击底部Tab的时候的页面跳转
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
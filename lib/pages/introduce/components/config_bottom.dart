import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigBottomView extends StatefulWidget {
  BuildContext parentContext;

  ConfigBottomView({super.key, required this.parentContext});

  static ConfigBottomView buildWidget(BuildContext context) {
    return ConfigBottomView(parentContext: context);
  }

  @override
  State<StatefulWidget> createState() {
    return _ConfigBottomViewState();
  }
}

class _ConfigBottomViewState extends State<ConfigBottomView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();

  var currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height - 200;
    return Container(
      height: height,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            BrnBaseTitle(
              title: '我的配置',
            ),
            Expanded(
              child: Container(
                  child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [_configItemsListView(), _addConfigItemsView()],
              )),
            ),
            _buttonsView()
          ],
        ),
      ),
    );
  }

  Widget _configItemsListView() {
    return ListView(
      shrinkWrap: true,
      children: [_configItemCell()],
    );
  }

  Widget _addConfigItemsView() {
    return Container();
  }

  Widget _configItemCell() {
    return Container(
      height: 68,
      color: Colors.red,
    );
  }

  Widget _buttonsView() {
    var s_width = (context.width - 24 - 12)/3;
    if (currentPage == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 44,
              child: BrnSmallOutlineButton(width: s_width, title: '取消', onTap: () {
                _pageController.jumpToPage(0);
                setState(() {
                  currentPage = 0;
                });
              },),
            ),
            Container(height: 44,child: BrnSmallMainButton(title: '保存配置', width: s_width*2,)),
          ],
        )
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: BrnBigMainButton(
        title: '添加配置',
        onTap: () {
          BrnToast.show('添加配置', context, verticalOffset: 200);
          _pageController.jumpToPage(1);
          setState(() {
            currentPage = 1;
          });
        },
      ),
    );
  }
}

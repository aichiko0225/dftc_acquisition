import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme_config.dart';

class ConfigItemProperty {
  String? name;
  int type;

  ConfigItemProperty({this.name, this.type = 0});

  static ConfigItemProperty defalutProperty() {
    return ConfigItemProperty();
  }
}

class ConfigItem {
  String name;
  String? desc;

  List<ConfigItemProperty> propArray;

  ConfigItem(this.name, {required this.propArray, this.desc});
}

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
  final themeConfig = Get.find<ThemeConfig>();

  var currentPage = 0;

  ConfigItem? addItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _addConfigProperty() {
    if (addItem != null) {
      var propArr = addItem?.propArray ?? [];
      propArr.add(ConfigItemProperty.defalutProperty());
      var _addItem = addItem!;
      _addItem.propArray = propArr;
      setState(() {
        addItem = _addItem;
      });
    }
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
    return Container(
      color: themeConfig.fillBody,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 20,
          ),
          _configItemCell(),
          Container(
            height: 12,
          ),
          _configItemCell(),
          Container(
            height: 12,
          ),
          _configItemCell()
        ],
      ),
    );
  }

  Widget _addConfigItemsView() {
    var propsArr = addItem?.propArray ?? [];

    // var widgetArr = <Widget>[];

    var widgetArr = propsArr.map((e) {
      var index = propsArr.indexOf(e);
      var arr = index > 0
          ? [
              Container(
                height: 12,
              ),
            ]
          : [];
      return Column(
        children: [
          ...arr,
          BrnBaseTitle(
            title: '配置字段',
            customActionWidget:
                index > 0 ? Icon(Icons.minimize_outlined) : null,
          ),
          BrnTextInputFormItem(
            title: '字段名称',
            isRequire: true,
            hint: '请输入字段名称',
          ),
          _buildLineView(),
          BrnTextSelectFormItem(
            title: '字段类型',
            isRequire: true,
            hint: '请选择字段类型',
          ),
        ],
      );
    }).toList();

    return Container(
      color: themeConfig.fillBody,
      child: ListView(
        children: [
          Container(
            height: 20,
          ),
          BrnTextInputFormItem(
            title: '配置名称',
            isRequire: true,
            hint: '请输入配置名称',
          ),
          _buildLineView(),
          BrnTextInputFormItem(
            title: '配置描述',
            isRequire: false,
            hint: '请输入配置描述',
          ),
          Container(
            height: 20,
          ),
          ...widgetArr,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
            child: BrnBigOutlineButton(
              title: '添加字段',
              onTap: () {
                BrnToast.show('添加字段', context);
                _addConfigProperty();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLineView(
      {double? height = 1,
      double? indent = 15,
      double? endIndent = 15,
      Color? color = const Color(0xFFD8D8D8)}) {
    return Divider(
      height: height,
      indent: indent,
      endIndent: endIndent,
      color: color,
    );
  }

  Widget _configItemCell() {
    return Container(
      color: Colors.red,
      child: BrnExpandableGroup(
        title: '配置名称',
        children: [
          BrnTextSelectFormItem(
            title: '字段名称1',
            hint: '字段类型',
          ),
          BrnTextSelectFormItem(
            title: '字段名称2',
            hint: '字段类型',
          ),
          BrnTextSelectFormItem(
            title: '字段名称3',
            hint: '字段类型',
          ),
        ],
      ),
    );
  }

  Widget _buttonsView() {
    var s_width = (context.width - 24 - 12) / 3;
    if (currentPage == 1) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 44,
                child: BrnSmallOutlineButton(
                  width: s_width,
                  title: '取消',
                  onTap: () {
                    _pageController.jumpToPage(0);
                    setState(() {
                      currentPage = 0;
                    });
                  },
                ),
              ),
              Container(
                  height: 44,
                  child: BrnSmallMainButton(
                    title: '保存配置',
                    width: s_width * 2,
                    onTap: () {
                      BrnToast.show('保存配置', context);
                    },
                  )),
            ],
          ));
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
            addItem = ConfigItem('',
                propArray: [ConfigItemProperty.defalutProperty()]);
          });
        },
      ),
    );
  }
}

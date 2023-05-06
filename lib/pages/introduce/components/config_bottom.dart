import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme_config.dart';

class ConfigItemModel {
  String name;
  // 1：文本，2：图片，3：语音，4：视频
  int type;
  String? value;

  ConfigItemModel({required this.name, this.type = 1, this.value});
}

class ConfigBottomView extends StatefulWidget {
  BuildContext parentContext;

  final bool add;

  ConfigBottomView({super.key, required this.parentContext, this.add = false});


  @override
  State<StatefulWidget> createState() {
    return _ConfigBottomViewState();
  }
}

class _ConfigBottomViewState extends State<ConfigBottomView>
    with SingleTickerProviderStateMixin {

  final themeConfig = Get.find<ThemeConfig>();

  ConfigItemModel? configItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _addConfigProperty() {}

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
                    child: widget.add
                        ? _addConfigItemsView()
                        : _configItemsListView())),
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
    var propsArr = [];
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
      Color? color = const Color(0xFFF0F0F0)}) {
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
    if (widget.add) {
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
        onTap: () {},
      ),
    );
  }
}

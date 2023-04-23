import 'package:flutter/material.dart';

class TabBarItemData {

  String title;

  Image? icon;

  Image? activeIcon;
  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  /// 是否选中
  bool selected;

  TabBarItemData({
    required this.title,
    required this.builder,
    this.icon,
    this.activeIcon,
    this.selected = false,
  });

}

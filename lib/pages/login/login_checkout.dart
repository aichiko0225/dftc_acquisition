import 'package:dftc_acquisition/generated/assets.dart';
import 'package:flutter/material.dart';

///多选按钮
class LoginCheckbox extends StatefulWidget {
  /// bool 选项的选中状态，true表示选中，false未选中
  final void Function(bool) onValueChangedAtIndex;

  /// 初始值，是否被选择
  /// 默认false
  final bool isSelected;

  /// 是否禁用当前选项
  /// 默认false
  final bool disable;

  /// 配合使用的控件，比如卡片或者text
  final Widget? child;

  /// 选择按钮的padding
  /// 默认EdgeInsets.all(5)
  final EdgeInsets iconPadding;

  /// 控件是否在选择按钮的右边，
  /// true时 控件在选择按钮右边
  /// false时 控件在选择按钮的左边
  /// 默认true
  final bool childOnRight;

  /// 控件和选择按钮在row布局里面的alignment
  /// 默认值MainAxisAlignment.start
  final MainAxisAlignment mainAxisAlignment;

  /// 控件和选择按钮在row布局里面的mainAxisSize
  /// 默认值MainAxisSize.min
  final MainAxisSize mainAxisSize;

  final Image selectedImage = const Image(
    image: AssetImage(Assets.imagesIconSelection),
    width: 14,
    height: 14,
  );

  final Image unselectedImage = const Image(
    image: AssetImage(Assets.imagesIconUnselection),
    width: 14,
    height: 14,
  );

  LoginCheckbox({
    Key? key,
    required this.onValueChangedAtIndex,
    this.disable = false,
    this.isSelected = false,
    this.iconPadding = const EdgeInsets.all(5),
    this.child,
    this.childOnRight = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  });

  @override
  State<StatefulWidget> createState() {
    return _LoginCheckboxState();
  }
}

class _LoginCheckboxState extends State<LoginCheckbox> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Widget icon = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (widget.disable == true) return;
          widget.onValueChangedAtIndex(!widget.isSelected);
        },
        child: Container(
          padding: widget.iconPadding,
          child:
          widget.isSelected? (widget.selectedImage) : (widget.unselectedImage),
        ));

    Widget radioWidget;
    if (widget.child == null) {
      // 没设置左右widget的时候就不返回row
      radioWidget = icon;
    } else {
      List<Widget> list = [];
      if (widget.childOnRight) {
        list.add(icon);
        list.add(widget.child!);
      } else {
        list.add(widget.child!);
        list.add(icon);
      }
      radioWidget = Row(
        mainAxisSize: widget.mainAxisSize,
        mainAxisAlignment: widget.mainAxisAlignment,
        children: list,
      );
    }

    return radioWidget;
  }
}

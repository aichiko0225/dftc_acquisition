import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme_config.dart';
import './image_picker_controller.dart';
import './media_file.dart';

// 选择模式
enum PickerMode { all, onlyImage, onlyVideo }

// 添加图片或者视频的视图
class ImagePickerView extends StatefulWidget {
  ImagePickerController controller;

  // PickerMode pickerMode;

  // 暂时图片或者视频时，不显示添加按钮
  bool showAddMoreButton;

  final EdgeInsetsGeometry? padding;
  SliverGridDelegate? gridDelegate;

  final Function(Iterable<MediaFile>)? onFilesChange;

  ImagePickerView(
      {super.key,
      required this.controller,
      // this.pickerMode = PickerMode.all,
      this.showAddMoreButton = true,
      this.padding,
      this.gridDelegate,
      this.onFilesChange});

  @override
  State<StatefulWidget> createState() {
    return _ImagePickerViewState();
  }
}

class _ImagePickerViewState extends State<ImagePickerView> {
  late ScrollController scrollController;
  final gridViewKey = GlobalKey();
  final themeConfig = Get.find<ThemeConfig>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    widget.controller.addListener(updateUI);
  }

  @override
  void dispose() {
    widget.controller.removeListener(updateUI);
    scrollController.dispose();
    super.dispose();
  }

  void _pickImages() async {
    final result = await widget.controller.pickMedias();
    if (!result) return;
    if (widget.onFilesChange != null) {
      widget.onFilesChange!(widget.controller.fileArray);
    }
  }

  void _deleteImage(MediaFile mediaFile) {
    widget.controller.removeMedia(mediaFile);
    if (widget.onFilesChange != null) {
      widget.onFilesChange!(widget.controller.fileArray);
    }
  }

  @override
  Widget build(BuildContext context) {
    var children = _gridViewItems(
        widget.controller.fileArray.toList(), widget.showAddMoreButton);
    return Container(
      color: Colors.white,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: GridView(
        key: gridViewKey,
        shrinkWrap: true,
          primary: false,
        gridDelegate: widget.gridDelegate ??
            const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
        children: children,
      ),
    );
  }

  List<Widget> _gridViewItems(List<MediaFile> mediaFileArr, bool hasAdd) {
    var maxCount = widget.controller.maxCount;
    List<Widget> arr  = [];
    if (hasAdd && mediaFileArr.length < maxCount) {
      // 如果文件数量少于最大值，则需要添加一个ADD按钮
      var addButtonItem = InkWell(
        onTap: () {
          _pickImages();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: themeConfig.borderColorBase ?? Color(0xFFF0F0F0))
          ),
          child: Icon(Icons.add, color: themeConfig.colorTextBase,),
        ),
      );
      arr.add(addButtonItem);
    }
    return arr;
  }

  @override
  void didUpdateWidget(covariant ImagePickerView oldWidget) {
    if (oldWidget == null) return;
    if (widget.controller != oldWidget.controller) {
      _migrate(widget.controller, oldWidget.controller, updateUI);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _migrate(Listenable a, Listenable b, void Function() listener) {
    b.removeListener(listener);
    a.addListener(listener);
  }

  void updateUI() {
    setState(() {});
  }
}

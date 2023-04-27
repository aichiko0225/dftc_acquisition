import 'package:bruno/bruno.dart';

const double PICKER_ITEM_HEIGHT = 44;

class SingleTextRowDelegate implements BrnMultiDataPickerDelegate {
  var selectedIndex;

  List<String> textList;

  SingleTextRowDelegate({required this.textList, this.selectedIndex = 0});

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return selectedIndex;
    }
    return 0;
  }

  @override
  int numberOfComponent() {
    return 1;
  }

  @override
  int numberOfRowsInComponent(int component) {
    if (component == 0) {
      return textList.length;
    }
    return 0;
  }

  @override
  double? rowHeightForComponent(int component) {
    return PICKER_ITEM_HEIGHT;
  }

  @override
  void selectRowInComponent(int component, int row) {
    if (0 == component) {
      selectedIndex = row;
    }
  }

  @override
  String titleForRowInComponent(int component, int index) {
    if (0 == component) {
      return textList[index];
    }
    throw UnimplementedError();
  }

}
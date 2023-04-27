import 'package:get/get.dart';

class QuestionnaireLogic extends GetxController {
  List<String> sceneDataArr = [];

  var selectIndexArr = <int>[];

  var inquiryText = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    sceneDataArr = [
      '场景一：上车前/远程控制',
      '场景二：接近车辆，进入车内',
      '场景三：酒店出发/小区行驶',
      '场景四：城市驾驶',
      '场景五：高速驾驶',
      '场景六：山路/高原驾驶',
      '场景七：车机系统',
      '场景八：抵达目的地/离车',
      '体验类问题反馈',
      '故障类问题反馈'
    ];
  }

  selectSceneItem(int index) {
    var arr = selectIndexArr;
    if (arr.contains(index)) {
      arr.remove(index);
    } else {
      arr.add(index);
    }
    arr.sort();
    print(arr);
    selectIndexArr = arr;
    update();
  }

  updateInquiryText(String text) {
    inquiryText.value = text;
  }
}

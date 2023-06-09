
import 'package:flutter/material.dart';

// 场景提示弹框
class SceneParticularsPage extends StatefulWidget {
  const SceneParticularsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SceneParticularsState();
  }
}

class _SceneParticularsState extends State<SceneParticularsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
        child: Column(
          children: [
            _sceneTitle(),
            _sceneList(),
            _sceneOne(),
            _sceneScore(),
            _oneIcon()
          ],
        ));
  }

  //
  Widget _sceneTitle() {
    return Container(
      height: 50,
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '场景一',
                textAlign: TextAlign.left,
              )),
        ],
      ),
    );
  }

  //
  Widget _sceneList() {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(
        '场景说明',
        selectionColor: Colors.black,
      ),
    ));
  }

  //
  Widget _sceneOne() {
    return Container(
      height: 200,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('场景一：上车前/远程控制'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('(说明：评价远程控制发动机启动、空调启动、通风等功能，查询车辆位置、仪表等信息的体验)'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('例如：场景一包含10个单项选择，每个选择都可以添加描述、语言、图片、视频'),
          ),
        ],
      ),
    );
  }

  //
  Widget _sceneScore() {
    return Container(
      height: 200,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text('评分标准'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('5分及以下为较差，6分合格，7分一般，7.5较好，8分及以上为很好'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('您可以在评分时写下描述'),
          ),
        ],
      ),
    );
  }

//
  Widget _oneIcon() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 40,
        ),
        onPressed: () {

        },
      ),
    );
  }
}

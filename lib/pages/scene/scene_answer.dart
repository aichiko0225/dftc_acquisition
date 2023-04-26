import 'package:flutter/material.dart';

class SceneAnswer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SceneAnswerOne();
  }
}

class SceneAnswerOne extends State<SceneAnswer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("回答详情"),
      ),
      body: Column(
        children: [_sceneTitle(),_sceneList()],
      ),
    );
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
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            '场景说明:评价远程控制发动机启动、空调启动、通风等功能，查询车辆位置、仪表灯信息的体验',
            selectionColor: Colors.black,
          ),
        ));
  }
}

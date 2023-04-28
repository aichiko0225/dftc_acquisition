import 'package:dftc_acquisition/generated/assets.dart';
import 'package:flutter/material.dart';

class ScoreSelect extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScoreSelectState();
  }
}

class _ScoreSelectState extends State<ScoreSelect> {

  final _iconPathArr = [
    Assets.imagesIconEmoji5cai,
    Assets.imagesIconEmoji4cai,
    Assets.imagesIconEmoji3cai,
    Assets.imagesIconEmoji2cai,
    Assets.imagesIconEmoji1cai,
  ];

  final _scoreNameArr = [
    '很差', '较差', '一般', '较好', '很好'
  ];

  @override
  Widget build(BuildContext context) {

    var cellArr = _scoreNameArr.map((e) {
      return _scoreCell(e);
    }).toList();

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: cellArr,
      ),
    );
  }

  Widget _scoreCell(String name) {
    var index = _scoreNameArr.indexOf(name);
    var iconPath = _iconPathArr[index];
    return InkWell(
      child: Container(
        child: Column(
          children: [
            Image(image: AssetImage(iconPath), width: 40, height: 40,),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(name),
            )
          ],
        ),
      ),
    );
  }

}

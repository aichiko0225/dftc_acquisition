import 'package:flutter/material.dart';

class IntroduceEvaluate extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Evaluate();
  }
}

class Evaluate extends State<IntroduceEvaluate> {  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text("试驾评价")),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

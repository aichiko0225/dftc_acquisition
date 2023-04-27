import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/extensions.dart';
import 'evaluation_details_logic.dart';

class EvaluationDetailsPage extends StatefulWidget {
  @override
  State<EvaluationDetailsPage> createState() => _EvaluationDetailsPageState();
}

class _EvaluationDetailsPageState extends State<EvaluationDetailsPage> {
  final logic = Get.put(EvaluationDetailsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '评价详情',
          style: DFTextStyle.titleStyle,
        ),
      ),
      body: Container(
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<EvaluationDetailsLogic>();
    super.dispose();
  }
}
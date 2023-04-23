import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'questionnaire_logic.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final logic = Get.put(QuestionnaireLogic());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    EasyLoading.showSuccess('99999');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('问卷'),),
    );
  }

  @override
  void dispose() {
    Get.delete<QuestionnaireLogic>();
    super.dispose();
  }
}
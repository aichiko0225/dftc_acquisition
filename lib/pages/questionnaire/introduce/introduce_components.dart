import 'package:bruno/bruno.dart';
import 'package:dftc_acquisition/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';

class EvaluateView extends StatefulWidget {

  EvaluateView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EvaluateViewState();
  }
}

class _EvaluateViewState extends State<EvaluateView> {
  final themeConfig = Get.find<ThemeConfig>();

  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (selectedIndex > 0) {
      return _vehicleSelectedView();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(
              'M18试驾评价',
              style: TextStyle(
                  color: themeConfig.colorTextBase,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1),
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return _imageEvaluate(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  //
  Widget _imageEvaluate(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        child: Column(
          children: [
            Image(
              image: AssetImage('./statics/images/m18.jpeg'),
              fit: BoxFit.fill,
              width: 70,
              height: 70,
            ),
            Text(
              '车辆编号',
              style: TextStyle(color: themeConfig.colorTextBase),
            ),
          ],
        ),
      ),
    );
  }

  //评价
  Widget _vehicleSelectedView() {
    return Container(
      color: themeConfig.fillBody,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(
              'M18试驾评价',
              style: TextStyle(
                  color: themeConfig.colorTextBase,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('./statics/images/m18.jpeg'),
                        fit: BoxFit.fill,
                        width: 70,
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '车辆编号',
                          style: TextStyle(color: themeConfig.colorTextBase),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = -1;
                    });
                  },
                  child: Text(
                    '返回选择',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(themeConfig.brandPrimary)),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 20),
                  child: Text(
                    '车辆信息',
                    style: TextStyle(
                        color: themeConfig.colorTextBase,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                BrnTextInputFormItem(
                  backgroundColor: themeConfig.fillBody,
                  title: "车辆VIN",
                  isEdit: false,
                  controller: TextEditingController(text: 'N9011050'),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: TextButton(
              onPressed: () {
                Get.toNamed(Routes.questionnaire);
              },
              child: Text(
                '立即评价',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(themeConfig.brandPrimary)),
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessIntroduceView extends StatelessWidget {
  ThemeConfig themeConfig;

  BusinessIntroduceView({super.key, required this.themeConfig});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeConfig.fillBody,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 文本描述
            Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'M18业务介绍',
                      style: TextStyle(
                          color: themeConfig.colorTextBase,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'M18拉练通过记录驾乘人员拉练感受，并对评价的结果做出分析，进而汇总天气、海拔、车型等客观因素对拉练结果的影响',
                      style: TextStyle(
                        color: themeConfig.colorTextBase,
                        fontSize: 14,
                      ),
                    )
                  ],
                )),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                child: Image(image: AssetImage('./statics/images/ditu.png'))),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'M18人员',
                        style: TextStyle(
                            color: themeConfig.colorTextBase,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Text('共40人  >'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

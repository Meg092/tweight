import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';
import 'target_weight_logic.dart';

class TargetWeightPage extends GetView<TargetWeightLogic> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Basic information',
                  style: TextStyle(color: Colors.grey),
                ),
                const Text(
                  'Target weight (kg)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CupertinoPicker(
                      itemExtent: 47,
                      onSelectedItemChanged: (v) {
                        controller.targetWeight = controller.allWeight[v];
                      },
                      children: controller.allWeight.map((e) {
                        return Text(
                          e.toString(),
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        );
                      }).toList()),
                ).marginSymmetric(vertical: 80),
                Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
                    .decorated(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(25))
                    .marginSymmetric(horizontal: 20)
                    .gestures(onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('birthday', controller.info['birthday']);
                  await prefs.setInt('currentWeight', controller.info['currentWeight']);
                  await prefs.setInt('targetWeight', controller.targetWeight);
                  Get.offAllNamed('/weight_tab');
                })
              ].toColumn(),
            ),
          ),
        ),
      ),
    );
  }
}

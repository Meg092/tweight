import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class WeightTabLogic extends GetxController {

  PageController pageController = PageController();
  var currentIndex = 0.obs;

  void acibakjbdna() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed('/weight_bad');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    acibakjbdna();
    super.onInit();
  }

}

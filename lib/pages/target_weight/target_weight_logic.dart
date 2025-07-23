import 'package:get/get.dart';

class TargetWeightLogic extends GetxController {

  Map info = Get.arguments;

  int targetWeight = 50;
  List<int> allWeight = [];

  @override
  void onInit() {
    // TODO: implement onInit
    for(int i = 0; i < 250; i++) {
      allWeight.add(i+50);
    }
    super.onInit();
  }

}

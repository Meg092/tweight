
import 'package:get/get.dart';

class CurrentWeightLogic extends GetxController {

  Map info = Get.arguments;

  int currentWeight = 50;
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

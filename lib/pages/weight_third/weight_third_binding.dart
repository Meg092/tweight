import 'package:get/get.dart';

import 'weight_third_logic.dart';

class WeightThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeightThirdLogic());
  }
}

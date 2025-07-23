import 'package:get/get.dart';

import 'current_weight_logic.dart';

class CurrentWeightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CurrentWeightLogic());
  }
}

import 'package:get/get.dart';

import 'target_weight_logic.dart';

class TargetWeightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TargetWeightLogic());
  }
}

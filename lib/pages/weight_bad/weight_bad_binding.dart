import 'package:get/get.dart';

import 'weight_bad_logic.dart';

class WeightBadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeightBadLogic());
  }
}

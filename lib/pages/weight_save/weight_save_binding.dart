import 'package:get/get.dart';

import 'weight_save_logic.dart';

class WeightSaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      WeightSaveLogic(),
      permanent: true,
    );
  }
}

import 'package:get/get.dart';

import 'birthday_logic.dart';

class BirthdayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BirthdayLogic());
  }
}

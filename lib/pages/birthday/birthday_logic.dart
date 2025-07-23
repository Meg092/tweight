import 'package:get/get.dart';

class BirthdayLogic extends GetxController {

  DateTime birthday = DateTime.now().subtract(const Duration(days: 365 * 18));

}

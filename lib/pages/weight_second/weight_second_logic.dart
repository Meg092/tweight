import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../db_weight/db_weight.dart';
import '../../db_weight/weight_entity.dart';

class WeightSecondLogic extends GetxController {
  DBWeight dbWeight = Get.find<DBWeight>();

  CalendarFormat calendarFormat = CalendarFormat.month;

  var currentDate = DateTime.now();
  var currentWidget = ''.obs;

  WeightEntity? entity;
  List<int> list = [];

  commit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentW = prefs.getInt('currentWeight') ?? 0;
    if (entity == null) {
      final currentEntity = WeightEntity(
          id: 0,
          createdTime: currentDate,
          currentWeight: currentW,
          list: list
      );
      await dbWeight.insertWeight(currentEntity);
    } else {
      entity!.list = list;
      await dbWeight.updateWeight(entity!);
    }
    await getData();
  }

  getData() async {
    List<WeightEntity> allWeight = await dbWeight.getWeightAllData();
    entity = allWeight.firstWhereOrNull((e) =>
        e.createdTime.year == currentDate.year &&
        e.createdTime.month == currentDate.month &&
        e.createdTime.day == currentDate.day);
    list = entity?.list ?? [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final hereWeight = prefs.getInt('currentWeight') ?? 0;
    currentWidget.value = entity != null
        ? entity!.currentWeight.toString()
        : hereWeight.toString();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}

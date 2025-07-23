import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:today_weight/db_weight/db_weight.dart';
import 'package:today_weight/db_weight/weight_entity.dart';

class WeightFirstLogic extends GetxController {
  DBWeight dbWeight = Get.find<DBWeight>();

  WeightEntity? entity;
  List<int> list = [];

  var currentTime = DateTime.now();
  var currentDate = ''.obs;

  var currentWeight = ''.obs;

  Timer? _timer;

  void startTimer() {
    getTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getTime();
    });
  }

  void getTime() {
    final now = DateTime.now();
    if (now.day != currentTime.day) {
      getData();
    }
    currentTime = now;
    currentDate.value = DateFormat('MM/dd/yyyy').format(now);
  }

  void getData() async {
    List<WeightEntity> allWeight = await dbWeight.getWeightAllData();
    entity = allWeight.firstWhereOrNull((e) =>
        e.createdTime.year == currentTime.year &&
        e.createdTime.month == currentTime.month &&
        e.createdTime.day == currentTime.day);
    list = entity?.list ?? [];
    currentWeight.value = entity?.currentWeight.toString() ?? '0';
    update();
  }

  commit() async {
    if (currentWeight.value.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter weight');
      return;
    }
    if (entity == null) {
     final currentEntity = WeightEntity(
        id: 0,
        createdTime: currentTime,
        currentWeight: int.parse(currentWeight.value),
        list: list
      );
      await dbWeight.insertWeight(currentEntity);
    } else {
      entity!.currentWeight = int.tryParse(currentWeight.value) ?? 0;
      entity!.list = list;
      await dbWeight.updateWeight(entity!);
    }
    getData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    startTimer();
    getData();
    super.onInit();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_weight/db_weight/db_weight.dart';

import '../../db_weight/weight_entity.dart';

class WeightThirdLogic extends GetxController {

  DBWeight dbWeight = Get.find<DBWeight>();

  List<int> allWeight = [];

  var todayWeight = ''.obs;
  var startWeight = ''.obs;
  var targetWeight = ''.obs;

  showDialog({bool isTarget = false}) async {
    int weight = 50;
    Get.dialog(AlertDialog(
      title: Text(isTarget ? 'Target weight' : 'Start weight',textAlign: TextAlign.center,),
      content: SizedBox(
        width: 300,
        height: 300,
        child: CupertinoPicker(
            itemExtent: 47,
            onSelectedItemChanged: (v) {
              weight = allWeight[v];
            },
            children: allWeight.map((e) {
              return Text(
                e.toString(),
                style: const TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold),
              );
            }).toList()),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black45),),
        ),
        TextButton(
          onPressed: () async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            if (isTarget) {
              await prefs.setInt('targetWeight', weight);
            } else {
              await prefs.setInt('currentWeight', weight);
            }
            getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }

  cleanWeightData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbWeight.cleanAllData();
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('currentWeight');
            await prefs.remove('targetWeight');
            await prefs.remove('birthday');
            Get.offAllNamed('/birthday');
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutWeightUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 76,
        height: 76,
      ),
      children: [
        const Text(
            """We can record your daily weight for you"""),
      ],
      context: context,
    );
  }

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    startWeight.value = prefs.getInt('currentWeight')?.toString() ?? '';
    targetWeight.value = prefs.getInt('targetWeight')?.toString() ?? '';
    List<WeightEntity> allWeight = await dbWeight.getWeightAllData();
    final currentTime = DateTime.now();
    WeightEntity? entity = allWeight.firstWhereOrNull((e) =>
    e.createdTime.year == currentTime.year &&
        e.createdTime.month == currentTime.month &&
        e.createdTime.day == currentTime.day);

    todayWeight.value = entity?.currentWeight.toString() ?? startWeight.value;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    getData();
    for(int i = 0; i < 250; i++) {
      allWeight.add(i+50);
    }
    super.onInit();
  }

}

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:today_weight/main.dart';
import 'birthday_logic.dart';

class BirthdayPage extends GetView<BirthdayLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Basic information',
                style: TextStyle(color: Colors.grey),
              ),
              const Text(
                'Your year of birth',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 300,
                child: DateTimePickerWidget(
                  dateFormat: 'yyyy',
                  initDateTime: controller.birthday,
                  pickerTheme: const DateTimePickerTheme(
                      cancel: null,
                      confirm: null,
                      title: null,
                      titleHeight: 0,
                      itemHeight: 50,
                      itemTextStyle:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  onChange: (dateTime, List<int> index) {
                    controller.birthday = dateTime;
                  },
                ),
              ).marginSymmetric(vertical: 80),
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'Next',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
                  .decorated(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(25))
                  .marginSymmetric(horizontal: 20)
                  .gestures(onTap: () {
                    Map info = {
                      'birthday': controller.birthday.toIso8601String()
                    };
                Get.toNamed('/current_weight', arguments: info);
              })
            ].toColumn(),
          ),
        ),
      ),
    );
  }
}

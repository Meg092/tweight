import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../main.dart';
import 'weight_second_logic.dart';

class WeightSecondPage extends GetView<WeightSecondLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Task data'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<WeightSecondLogic>(
                init: WeightSecondLogic(),
                builder: (_) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: TableCalendar(
                          firstDay: DateTime.utc(2020, 10, 16),
                          lastDay: DateTime.utc(2050, 3, 14),
                          focusedDay: DateTime.now(),
                          calendarFormat: controller.calendarFormat,
                          onFormatChanged: (format) {
                            if (controller.calendarFormat != format) {
                              controller.calendarFormat = format;
                              controller.update();
                            }
                          },
                          currentDay: controller.currentDate,
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                                color: primaryColor, shape: BoxShape.circle),
                          ),
                          onDaySelected: (selectedDay, focusedDay) {
                            controller.currentDate = selectedDay;
                            controller.update();
                            controller.getData();
                          },
                        ),
                      ).decorated(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        child: <Widget>[
                          Obx(() {
                            return Text(
                              controller.currentWidget.value,
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            );
                          }),
                          const Text(
                            'KG',
                            style: TextStyle(fontSize: 40, color: Colors.grey,fontWeight: FontWeight.bold),
                          )
                        ].toRow(mainAxisAlignment: MainAxisAlignment.center),
                      ).decorated(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 7,
                            itemBuilder: (_, index) {
                              return Container(
                                width: double.infinity,
                                color: Colors.transparent,
                                child: <Widget>[
                                  SizedBox(
                                    height: 40,
                                    child: <Widget>[
                                      Image.asset(
                                        'assets/icon$index.webp',
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(child: Text(itemTitles[index])),
                                      Icon(
                                        Icons.check_circle,
                                        size: 25,
                                        color: controller.list.contains(index)
                                            ? primaryColor
                                            : Colors.grey,
                                      )
                                    ].toRow(),
                                  ),
                                  Divider(
                                    height: 15,
                                    color: Colors.grey[300],
                                  )
                                ].toColumn(),
                              ).gestures(onTap: () async {
                                controller.list.contains(index)
                                    ? controller.list.remove(index)
                                    : controller.list.add(index);
                                await controller.commit();
                              });
                            }),
                      ).decorated(
                          color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    ].toColumn(),
                  );
                }).marginAll(15)),
      ).decorated(
          gradient: const LinearGradient(
              colors: [Color(0xffd0ffed), Color(0xfff8f8f8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.5])),
    );
  }
}

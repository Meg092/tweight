import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:today_weight/pages/weight_first/weight_text_field.dart';

import '../../main.dart';
import 'weight_first_logic.dart';

class WeightFirstPage extends GetView<WeightFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Today task'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<WeightFirstLogic>(init: WeightFirstLogic(),builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              Obx(() {
                return Text(
                  controller.currentDate.value,
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.bold),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: <Widget>[
                  const Text(
                    '''Today's weight''',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  <Widget>[
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: WeightTextField(
                          value: controller.currentWeight.value,
                          hintText: 'Enter your weight',
                          isInteger: true,
                          textAlign: TextAlign.center,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                          maxLength: 3,
                          onChange: (v) {
                            controller.currentWeight.value = v;
                          }),
                    ),
                    const Text(
                      'KG',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    )
                  ].toStack(alignment: Alignment.centerRight),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      'Commit',
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
                    controller.commit();
                  })
                ].toColumn(),
              ).decorated(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 3))
                  ]),
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
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  const Text('Completed'),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 7,
                    ).decorated(color: Colors.grey[200]),
                    LayoutBuilder(builder: (_, max) {
                      return Container(
                        width: max.maxWidth *
                            (controller.entity?.list.length ?? 0) /
                            7,
                        height: 7,
                      ).decorated(color: primaryColor);
                    })
                  ].toStack()),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(controller.entity?.completionDegree ?? '0%')
                ].toRow(),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(15))
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

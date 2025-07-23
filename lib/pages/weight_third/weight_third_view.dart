import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'weight_third_logic.dart';

class WeightThirdPage extends GetView<WeightThirdLogic> {
  Widget _item(int index, BuildContext context) {
    final titles = ['Clean all  data', 'About us'];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(titles[index]),
        index == 1 ? const Text("1.0.0").paddingOnly(right: 10) : const Icon(
          Icons.keyboard_arrow_right,
          size: 20,
          color: Colors.grey,
        )
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      switch (index) {
        case 0:
          controller.cleanWeightData();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.getData();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[
                Container(
                  color: Colors.transparent,
                  height: 40,
                  child: <Widget>[
                    const Text('Today weight'),
                    <Widget>[
                      Obx(() {
                        return Text(controller.todayWeight.value);
                      }),
                      const Text(
                        'kg',
                        style: TextStyle(color: Colors.grey),
                      )
                    ].toRow(mainAxisAlignment: MainAxisAlignment.end)
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ),
                Container(
                  color: Colors.transparent,
                  height: 40,
                  child: <Widget>[
                    const Text('Start weight'),
                    <Widget>[
                      Obx(() {
                        return Text(controller.startWeight.value);
                      }),
                      const Text(
                        'kg',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 25,
                        color: Colors.grey,
                      )
                    ].toRow(mainAxisAlignment: MainAxisAlignment.end)
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ).gestures(onTap: (){
                  controller.showDialog();
                }),
                Container(
                  color: Colors.transparent,
                  height: 40,
                  child: <Widget>[
                    const Text('Target weight'),
                    <Widget>[
                      Obx(() {
                        return Text(controller.targetWeight.value);
                      }),
                      const Text(
                        'kg',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 25,
                        color: Colors.grey,
                      )
                    ].toRow(mainAxisAlignment: MainAxisAlignment.end)
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ).gestures(onTap: (){
                  controller.showDialog(isTarget: true);
                })
              ].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[_item(0, context), _item(1, context)].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12))
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ).marginAll(15)),
      ).decorated(
          gradient: const LinearGradient(
              colors: [Color(0xffd0ffed), Color(0xfff8f8f8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.5])),
    );
  }
}

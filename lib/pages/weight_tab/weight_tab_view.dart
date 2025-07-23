import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_weight/pages/weight_first/weight_first_view.dart';
import 'package:today_weight/pages/weight_second/weight_second_view.dart';
import 'package:today_weight/pages/weight_third/weight_third_view.dart';

import 'weight_tab_logic.dart';

class WeightTabPage extends GetView<WeightTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [WeightFirstPage(),WeightSecondPage(),WeightThirdPage()],
      ),
      bottomNavigationBar: Obx(() => _navWeBars()),
    );
  }

  Widget _navWeBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/item0Grey.webp',
            width: 22,
            fit: BoxFit.cover,
          ),
          activeIcon: Image.asset(
            'assets/item0Light.webp',
            width: 22,
            fit: BoxFit.cover,
          ),
          label: 'Today task',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/item1Grey.webp',
            width: 22,
            fit: BoxFit.cover,
          ),
          activeIcon: Image.asset(
            'assets/item1Light.webp',
            width: 22,
            fit: BoxFit.cover,
          ),
          label: 'Task data',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/item2Grey.webp',
            width: 22,
            fit: BoxFit.cover,
          ),
          activeIcon: Image.asset(
            'assets/item2Light.webp',
            width: 22,
            fit: BoxFit.cover,
          ),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) async {
        controller.currentIndex.value = index;
        controller.pageController.jumpToPage(index);
      },
    );
  }
}

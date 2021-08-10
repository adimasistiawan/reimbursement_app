import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siepegawai/login.dart';
import 'package:siepegawai/pages/adminhome.dart';
import 'package:siepegawai/pages/pegawaihome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String a;
  String b;
  final SharedPreferences pref = await SharedPreferences.getInstance();
  a = pref.getString('token');
  b = pref.getString('status');
  runApp(MyApp(
    token: a,
    status: b,
  ));
}

class MyApp extends StatelessWidget {
  String token;
  String status;
  MyApp({this.token, this.status});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Duration(milliseconds: 300),
      home: token == null
          ? LoginPage()
          : status == "admin"
              ? AdminHome()
              : PegawaiHome(),
    );
  }
}

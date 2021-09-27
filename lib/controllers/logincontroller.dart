import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siepegawai/api/service.dart';
import 'package:siepegawai/pages/adminhome.dart';
import 'package:siepegawai/pages/pegawaihome.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    await Services().login(email.text, password.text).then((value) {
      if (!value.isNull) {
        pref(value.token);
        Services().getProfile().then((val) {
          prefStatus(val.data.status);
          Get.back();
          if (val.data.status == "admin") {
            Get.to(AdminHome());
          } else {
            Get.to(PegawaiHome());
          }
        });
      } else {
        Get.back();
        Get.dialog(AlertDialog(
          content: Text("Email atau Password salah"),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ));
      }
    });
  }

  void pref(token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', "Bearer " + token);
    pref.setBool("is_login", true);
    print(pref.getString('token'));
  }

  void prefStatus(status) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('status', status);
    pref.setBool("is_login", true);
  }

  // @override
  // void onClose() {
  //   password?.dispose();
  //   email?.dispose();
  //   super.onClose();
  // }
}

class LoginClass {
  int success;
  String message;
  String token;

  LoginClass({this.success, this.message, this.token});

  LoginClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    return data;
  }
}

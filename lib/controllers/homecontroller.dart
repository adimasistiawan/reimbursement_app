import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/api/service.dart';
import 'package:siepegawai/model/homeadmin.dart';
import 'package:siepegawai/model/homepegawai.dart';
import 'package:siepegawai/model/profile.dart';
import 'package:siepegawai/model/user.dart' as userModel;

class HomeController extends GetxController {
  var data_admin = HomeAdminClass().obs;
  var data_pegawai = HomePegawaiClass().obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController no_hp = TextEditingController();
  TextEditingController alamat = TextEditingController();
  String divisi;
  var isLoading = true.obs;
  @override
  void onInit() async {
    super.onInit();
  }

  getDataAdmin() async {
    isLoading.value = true;
    await Services().homeAdmin().then((val) {
      data_admin.value = val;
      email.text = val.data.user.email;
      nama.text = val.data.user.nama;
    });
    isLoading.value = false;
    update();
  }

  getDataPegawai() async {
    isLoading.value = true;
    await Services().homePegawai().then((val) {
      data_pegawai.value = val;
      email.text = val.data.user.email;
      nama.text = val.data.user.nama;
      alamat.text = val.data.user.alamat;
      no_hp.text = val.data.user.noHp;
    });
    isLoading.value = false;
    update();
  }

  updateUserPegawai(int id) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    userModel.User user = userModel.User(
      id: id,
      nama: nama.text,
      email: email.text,
      password: password.text,
      alamat: alamat.text,
      noHp: no_hp.text,
    );

    await Services().updateProfilePegawai(user).then((value) {
      if (value.isNull) {
        Get.back();
        Get.dialog(AlertDialog(
          content: Text("Data berhasil diubah"),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ));
        getDataPegawai();
      } else {
        Get.back();
        Get.dialog(AlertDialog(
          content: Text(value.message),
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

  updateUserAdmin(int id) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    userModel.User user = userModel.User(
      id: id,
      nama: nama.text,
      email: email.text,
      password: password.text,
    );

    await Services().updateProfileAdmin(user).then((value) {
      if (value.isNull) {
        Get.back();
        getDataAdmin();
        Get.dialog(AlertDialog(
          content: Text("Data berhasil diubah"),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ));
      } else {
        Get.back();
        Get.dialog(AlertDialog(
          content: Text(value.message),
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
}

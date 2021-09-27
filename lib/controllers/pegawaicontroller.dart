import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:siepegawai/api/service.dart';
import 'package:flutter/material.dart';
import 'package:siepegawai/model/user.dart';
import 'package:siepegawai/pages/admin/pegawai/pegawaidetail.dart';

class PegawaiController extends GetxController {
  var user = User().obs;
  var alluser = List<AllUser>().obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController no_hp = TextEditingController();
  TextEditingController alamat = TextEditingController();
  String divisi;
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  getDataAllUser() async {
    nama.text = '';
    email.text = '';
    password.text = '';
    alamat.text = '';
    no_hp.text = '';
    divisi = '';
    isLoading.value = true;
    await Services().getAllUser().then((val) {
      alluser.value = val.data;
    });
    isLoading.value = false;
    update();
  }

  getDataUser(int id) async {
    isLoading2.value = true;
    await Services().getUser(id).then((val) {
      user.value = val.data;
      email.text = val.data.email;
      nama.text = val.data.nama;
      alamat.text = val.data.alamat;
      no_hp.text = val.data.noHp;
      divisi = val.data.divisi;
    });
    isLoading2.value = false;
    update();
  }

  deleteUser(int id) async {
    // Future.delayed(
    //     Duration.zero,
    //     () => Get.dialog(Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    await Services().deleteUser(id).then((value) {
      if (value.isNull) {
        getDataAllUser();
        Get.back();
        Get.back();
        Get.dialog(AlertDialog(
          content: Text("Data berhasil dihapus"),
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

  createUser() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    User user = User(
        nama: nama.text,
        email: email.text,
        password: password.text,
        alamat: alamat.text,
        noHp: no_hp.text,
        divisi: divisi);

    await Services().createUser(user).then((value) {
      if (value.isNull) {
        Get.back();
        getDataAllUser();
        Get.dialog(AlertDialog(
          content: Text("Data berhasil dibuat"),
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

  updateUser(int id) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    User user = User(
        id: id,
        nama: nama.text,
        email: email.text,
        password: password.text,
        alamat: alamat.text,
        noHp: no_hp.text,
        divisi: divisi);

    await Services().updateUser(user).then((value) {
      if (value.isNull) {
        Get.back();
        getDataUser(id);
        getDataAllUser();
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

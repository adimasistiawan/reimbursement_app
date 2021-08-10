import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/api/service.dart';
import 'package:siepegawai/model/cuti.dart';

class CutiController extends GetxController {
  var detail = CutiDetail().obs;
  var all = List<Cuti>().obs;
  var me = List<Cuti>().obs;
  var belum = List<Cuti>().obs;
  var telah = List<Cuti>().obs;
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  TextEditingController alasan = TextEditingController();
  TextEditingController dari = TextEditingController();
  TextEditingController sampai = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  getDataAll() async {
    belum.clear();
    telah.clear();
    isLoading.value = true;
    await Services().getCuti().then((val) {
      val.data.forEach((element) {
        if (element.status == "Belum Dikonfirmasi") {
          belum.add(element);
        } else {
          telah.add(element);
        }
      });
      all.value = val.data;
    });
    isLoading.value = false;
    update();
  }

  getDataUser() async {
    belum.clear();
    telah.clear();
    isLoading.value = true;
    await Services().getCuti().then((val) {
      val.data.forEach((element) {
        if (element.status == "Belum Dikonfirmasi") {
          belum.add(element);
        } else {
          telah.add(element);
        }
      });
      all.value = val.data;
    });
    isLoading.value = false;
    update();
  }

  getDetail(int id) async {
    isLoading2.value = true;
    await Services().detailCuti(id).then((val) {
      detail.value = val.data;
    });
    isLoading2.value = false;
    update();
  }

  create() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    Cuti cuti = Cuti(
      dari: dari.text,
      sampai: sampai.text,
      alasan: alasan.text,
    );

    await Services().createCuti(cuti).then((value) {
      if (value.isNull) {
        Get.back();
        getDataUser();
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

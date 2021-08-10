import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:siepegawai/api/service.dart';
import 'package:flutter/material.dart';
import 'package:siepegawai/controllers/homecontroller.dart';
import 'package:siepegawai/model/reimbursement.dart';
import 'package:siepegawai/model/user.dart';
import 'package:siepegawai/pages/admin/pegawai/pegawaidetail.dart';

class ReimbursementController extends GetxController {
  var detail = ReimbursementDetail().obs;
  var all = List<ReimbursementAll>().obs;
  var me = List<ReimbursementAll>().obs;
  var belum = List<ReimbursementAll>().obs;
  var telah = List<ReimbursementAll>().obs;
  TextEditingController nominal = TextEditingController();
  TextEditingController ketarangan = TextEditingController();
  File image;
  int telahcount = 0;
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  getDataAll() async {
    belum.clear();
    telah.clear();
    telahcount = 0;
    isLoading.value = true;
    await Services().getReimbursement().then((val) {
      val.data.forEach((element) {
        if (element.status == "Belum Dikonfirmasi") {
          belum.add(element);
        } else {
          telah.add(element);
          telahcount++;
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
    telahcount = 0;
    isLoading.value = true;
    await Services().getReimbursementUser().then((val) {
      val.data.forEach((element) {
        if (element.status == "Belum Dikonfirmasi") {
          belum.add(element);
        } else {
          telah.add(element);
          telahcount++;
        }
      });
      all.value = val.data;
    });
    isLoading.value = false;
    update();
  }

  getDetail(int id) async {
    isLoading2.value = true;
    await Services().detailReimbursement(id).then((val) {
      detail.value = val.data;
      print(val.data.nominal);
    });
    isLoading2.value = false;
    update();
  }

  create() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    await Services()
        .buatReimbursement(image, nominal.text, ketarangan.text)
        .then((val) {
      getDataUser();
      Get.back();
      Get.back();
    }).catchError((onError) {
      print(onError);
    });
  }

  updateData(ReimbursementDetail reimbursement) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    await Services().updateReimbursement(reimbursement).then((value) {
      if (value.isNull) {
        HomeController _home = Get.put(HomeController());
        Get.back();
        getDetail(reimbursement.id);
        getDataAll();
        _home.getDataAdmin();
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

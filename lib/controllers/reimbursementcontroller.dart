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
  var history = List<ReimbursementAll>().obs;
  var me = List<ReimbursementAll>().obs;
  var belum = List<ReimbursementAll>().obs;
  var telah = List<ReimbursementAll>().obs;
  HomeController _homeController = Get.put(HomeController());
  TextEditingController nominal = TextEditingController();
  TextEditingController ketarangan = TextEditingController();
  TextEditingController daritanggal = TextEditingController();
  TextEditingController sampaitanggal = TextEditingController();
  TextEditingController kode = TextEditingController();
  File image;
  String status;
  int selectedstatus;

  int telahcount = 0;
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var isLoading3 = true.obs;
  @override
  void onInit() {
    selectedstatus = 1;
    super.onInit();
  }

  getDataAll() async {
    belum.clear();
    telah.clear();
    telahcount = 0;
    isLoading.value = true;
    daritanggal.text = '';
    sampaitanggal.text = '';
    kode.text = '';
    status = 'Semua';
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

  getDataAllFilter() async {
    telah.clear();
    telahcount = 0;
    isLoading.value = true;
    await Services()
        .getReimbursementFilter(daritanggal.text, sampaitanggal.text, kode.text)
        .then((val) {
      val.data.forEach((element) {
        if (element.status != "Belum Dikonfirmasi") {
          telahcount++;
        }

        if (status == "Semua" && element.status != "Belum Dikonfirmasi") {
          telah.add(element);
        } else if (element.status == status) {
          telah.add(element);
        }
      });
    });
    isLoading.value = false;
    update();
  }

  getHistory(int id) async {
    daritanggal.text = '';
    sampaitanggal.text = '';
    kode.text = '';
    status = 'Semua';
    isLoading3.value = true;
    await Services().historyReimbursement(id).then((val) {
      history.value = val.data;
    });
    isLoading3.value = false;
    update();
  }

  getHistoryFilter(int id) async {
    history.clear();
    isLoading3.value = true;
    await Services()
        .historyReimbursementFilter(
            id, daritanggal.text, sampaitanggal.text, kode.text)
        .then((val) {
      val.data.forEach((element) {
        if (status == "Semua") {
          history.add(element);
        } else if (element.status == status) {
          history.add(element);
        }
      });
    });
    isLoading3.value = false;
    update();
  }

  getDataUser() async {
    belum.clear();
    telah.clear();
    ketarangan.text = '';
    nominal.text = '';
    telahcount = 0;
    isLoading.value = true;
    daritanggal.text = '';
    sampaitanggal.text = '';
    kode.text = '';
    status = 'Semua';
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

  getDataUserFilter() async {
    telah.clear();
    telahcount = 0;
    isLoading.value = true;
    await Services()
        .getReimbursementUserFilter(
            daritanggal.text, sampaitanggal.text, kode.text)
        .then((val) {
      val.data.forEach((element) {
        if (element.status != "Belum Dikonfirmasi") {
          telahcount++;
        }

        if (status == "Semua" && element.status != "Belum Dikonfirmasi") {
          telah.add(element);
        } else if (element.status == status) {
          telah.add(element);
        }
      });
    });
    isLoading.value = false;
    update();
  }

  getDetail(int id) async {
    isLoading2.value = true;
    await Services().detailReimbursement(id).then((val) {
      detail.value = val.data;
      ketarangan.text = val.data.keterangan;
      nominal.text = val.data.nominal.toString();
      print(val.data.nominal);
      _homeController.getDataPegawai();
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

  updateAllData(int id) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    await Services()
        .updateAllReimbursement(image, nominal.text, ketarangan.text, id)
        .then((val) {
      getDataUser();
      getDetail(id);
      Get.back();
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
    }).catchError((onError) {
      print(onError);
    });
  }

  deleteReimbursement(int id) async {
    await Services().deleteReimbursement(id).then((value) {
      if (value.isNull) {
        getDataUser();
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
}

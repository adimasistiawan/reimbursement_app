import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siepegawai/api/service.dart';
import 'package:siepegawai/controllers/homecontroller.dart';
import 'package:siepegawai/model/cuti.dart';

class CutiController extends GetxController {
  var detail = CutiDetail().obs;
  var all = List<Cuti>().obs;
  var me = List<Cuti>().obs;
  var belum = List<Cuti>().obs;
  var telah = List<Cuti>().obs;
  var history = List<Cuti>().obs;
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var isLoading3 = true.obs;
  HomeController _homeController = Get.put(HomeController());
  TextEditingController alasan = TextEditingController();
  TextEditingController dari = TextEditingController();
  TextEditingController sampai = TextEditingController();
  TextEditingController daritanggal = TextEditingController();
  TextEditingController sampaitanggal = TextEditingController();
  TextEditingController kode = TextEditingController();
  String status;
  int selectedstatus;

  @override
  void onInit() {
    selectedstatus = 1;
    super.onInit();
  }

  getDataAll() async {
    belum.clear();
    telah.clear();
    isLoading.value = true;
    daritanggal.text = '';
    sampaitanggal.text = '';
    kode.text = '';
    status = 'Semua';
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

  getDataAllFilter() async {
    telah.clear();
    isLoading.value = true;
    await Services()
        .getCutiFilter(daritanggal.text, sampaitanggal.text, kode.text)
        .then((val) {
      val.data.forEach((element) {
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
    isLoading3.value = true;
    daritanggal.text = '';
    sampaitanggal.text = '';
    kode.text = '';
    status = 'Semua';
    await Services().historyCuti(id).then((val) {
      history.value = val.data;
    });
    isLoading3.value = false;
    update();
  }

  getHistoryFilter(int id) async {
    history.clear();
    isLoading3.value = true;
    await Services()
        .historyCutiFilter(id, daritanggal.text, sampaitanggal.text, kode.text)
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
    isLoading.value = true;
    daritanggal.text = '';
    sampaitanggal.text = '';
    kode.text = '';
    status = 'Semua';
    await Services().getCutiUser().then((val) {
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

  getDataUserFilter() async {
    telah.clear();
    isLoading.value = true;
    await Services()
        .getCutiUserFilter(daritanggal.text, sampaitanggal.text, kode.text)
        .then((val) {
      val.data.forEach((element) {
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
    print(id);
    isLoading2.value = true;
    await Services().detailCuti(id).then((val) {
      detail.value = val.data;
      alasan.text = val.data.alasan;
      dari.text = val.data.dari;
      sampai.text = val.data.sampai;
      DateFormat formatterinput = DateFormat("yyyy-MM-dd");
      detail.value.dari =
          formatterinput.format(DateTime.parse(detail.value.dari));
      detail.value.sampai =
          formatterinput.format(DateTime.parse(detail.value.sampai));
      dari.text = formatterinput.format(DateTime.parse(dari.text));
      sampai.text = formatterinput.format(DateTime.parse(sampai.text));
      _homeController.getDataPegawai();
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

  updateData(CutiDetail cuti) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    await Services().updateCuti(cuti).then((value) {
      if (value.isNull) {
        HomeController _home = Get.put(HomeController());
        Get.back();
        getDetail(cuti.id);
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

  updateDataCuti(int id) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    Cuti cuti = Cuti(
      dari: dari.text,
      sampai: sampai.text,
      alasan: alasan.text,
    );

    await Services().updateDataCuti(cuti, id).then((value) {
      if (value.isNull) {
        Get.back();
        getDetail(id);
        getDataUser();
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

  delete(int id) async {
    await Services().deleteCuti(id).then((value) {
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

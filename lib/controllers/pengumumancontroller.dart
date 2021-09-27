import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:siepegawai/api/service.dart';
import 'package:flutter/material.dart';
import 'package:siepegawai/model/pengumuman.dart';
import 'package:siepegawai/model/pengumumandetail.dart';

class PengumumanController extends GetxController {
  var pengumuman = List<Pengumuman>().obs;
  var detail = PengumumanDetail().obs;
  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  getData() async {
    judul.text = '';
    isi.text = '';
    isLoading.value = true;
    await Services().getPengumuman().then((val) {
      pengumuman.value = val.data;
    });
    isLoading.value = false;
    update();
  }

  getDetail(int id) async {
    isLoading2.value = true;
    await Services().detailPengumuman(id).then((val) {
      detail.value = val.data;
      isi.text = val.data.isi;
      judul.text = val.data.judul;
    });
    isLoading2.value = false;
    update();
  }

  deletePengumuman(int id) async {
    await Services().deletePengumuman(id).then((value) {
      if (value.isNull) {
        getData();
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

  create() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    print(isi.text);
    Pengumuman pengumuman = Pengumuman(
      isi: isi.text,
      judul: judul.text,
    );

    await Services().createPengumuman(pengumuman).then((value) {
      if (value.isNull) {
        Get.back();
        getData();
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

  updateData(int id) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    Pengumuman pengumuman = Pengumuman(
      id: id,
      isi: isi.text,
      judul: judul.text,
    );

    await Services().updatePengumuman(pengumuman).then((value) {
      if (value.isNull) {
        Get.back();
        getDetail(id);
        getData();
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/controllers/cuticontroller.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/model/user.dart';
import 'package:siepegawai/pages/admin/cuti/belum.dart';
import 'package:siepegawai/pages/admin/cuti/telah.dart';
import 'package:siepegawai/pages/admin/reimbursement/belum.dart';
import 'package:siepegawai/pages/admin/reimbursement/telah.dart';
import 'package:siepegawai/pages/karyawan/cuti/belum.dart';
import 'package:siepegawai/pages/karyawan/cuti/tambah.dart';
import 'package:siepegawai/pages/karyawan/cuti/telah.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/belum.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/tambah.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/telah.dart';
import 'package:siepegawai/theme.dart';

class CutiPage extends StatefulWidget {
  @override
  _CutiPageState createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage>
    with SingleTickerProviderStateMixin {
  CutiController _cutiController = Get.put(CutiController());

  List<AllUser> _searchResult = [];
  TabController controller;

  @override
  void initState() {
    _cutiController.getDataAll();
    controller = new TabController(vsync: this, length: 2);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: grey,
      appBar: AppBar(
        backgroundColor: navy,
        title: Text(
          "Cuti",
          style: textWhite3,
        ),
        bottom: new TabBar(
          isScrollable: true,
          controller: controller,
          //source code lanjutan
          tabs: <Widget>[
            new Tab(
              child: Row(
                children: [
                  Text("Belum Dikonfirmasi "),
                  Obx(
                    () => Text(
                      _cutiController.belum.value.length == 0
                          ? ""
                          : _cutiController.belum.value.length.toString(),
                      style: textRed3,
                    ),
                  ),
                ],
              ),
            ),
            new Tab(
              child: Row(
                children: [
                  Text("Telah Dikonfirmasi "),
                ],
              ),
            ),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[CutiBelum(), CutiTelah()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/model/user.dart';
import 'package:siepegawai/pages/admin/reimbursement/belum.dart';
import 'package:siepegawai/pages/admin/reimbursement/telah.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/belum.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/tambah.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/telah.dart';
import 'package:siepegawai/theme.dart';

class ReimbursementPegawaiPage extends StatefulWidget {
  @override
  _ReimbursementPegawaiPageState createState() =>
      _ReimbursementPegawaiPageState();
}

class _ReimbursementPegawaiPageState extends State<ReimbursementPegawaiPage>
    with SingleTickerProviderStateMixin {
  ReimbursementController _reimbursementController =
      Get.put(ReimbursementController());

  List<AllUser> _searchResult = [];
  TabController controller;

  @override
  void initState() {
    _reimbursementController.getDataUser();
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
          "Reimbursement",
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
                      _reimbursementController.belum.value.length == 0
                          ? ""
                          : _reimbursementController.belum.value.length
                              .toString(),
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
                  Obx(
                    () => Text(
                      _reimbursementController.telah.value.length == 0
                          ? ""
                          : _reimbursementController.telah.value.length
                              .toString(),
                      style: textRed3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          ReimbursementBelumPegawai(),
          ReimbursementTelahPegawai()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(TambahReimbursement());
        },
        label: Text(
          'Buat',
          style: textWhite2,
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: navy,
      ),
    );
  }
}

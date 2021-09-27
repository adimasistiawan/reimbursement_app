import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/pegawaicontroller.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/model/user.dart';
import 'package:siepegawai/pages/admin/pegawai/pegawaidetail.dart';
import 'package:siepegawai/pages/admin/pegawai/tambahpegawai.dart';
import 'package:siepegawai/pages/admin/reimbursement/belum.dart';
import 'package:siepegawai/pages/admin/reimbursement/detail.dart';
import 'package:siepegawai/pages/admin/reimbursement/telah.dart';
import 'package:siepegawai/theme.dart';

class ReimbursementPage extends StatefulWidget {
  @override
  _ReimbursementPageState createState() => _ReimbursementPageState();
}

class _ReimbursementPageState extends State<ReimbursementPage>
    with SingleTickerProviderStateMixin {
  ReimbursementController _reimbursementController =
      Get.put(ReimbursementController());

  List<AllUser> _searchResult = [];
  TabController controller;

  @override
  void initState() {
    _reimbursementController.getDataAll();
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
                ],
              ),
            ),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          ReimbursementBelumAdmin(),
          ReimbursementTelahAdmin()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

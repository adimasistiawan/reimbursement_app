import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siepegawai/circle.dart';
import 'package:siepegawai/controllers/pengumumancontroller.dart';
import 'package:siepegawai/pages/admin/pegawai/pegawaidetail.dart';
import 'package:siepegawai/pages/admin/pegawai/tambahpegawai.dart';
import 'package:siepegawai/pages/admin/pengumuman/pengumumandetail.dart';
import 'package:siepegawai/pages/admin/pengumuman/tambah.dart';
import 'package:siepegawai/pages/karyawan/pengumuman/detail.dart';
import 'package:siepegawai/theme.dart';

class PengumumanPegawaiPage extends StatefulWidget {
  @override
  _PengumumanPegawaiPageState createState() => _PengumumanPegawaiPageState();
}

class _PengumumanPegawaiPageState extends State<PengumumanPegawaiPage> {
  PengumumanController _pengumumanController = Get.put(PengumumanController());
  DateFormat formatter = DateFormat("dd-MM-yyyy");
  @override
  void initState() {
    _pengumumanController.getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
          backgroundColor: navy,
          title: Text(
            "Pengumuman",
            style: textWhite3,
          )),
      body: Container(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Obx(() => _pengumumanController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : _pengumumanController.pengumuman.value.length == 0
                ? Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Tidak Ada",
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _pengumumanController.pengumuman.value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: 70,
                        padding: EdgeInsets.only(
                            top: 10, left: 18, right: 24, bottom: 10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 300,
                                  child: Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        style: textBlack2Bold,
                                        text: _pengumumanController
                                            .pengumuman.value[index].judul,
                                      ),
                                    ),
                                  ),
                                ),
                                CircleButton(
                                    onTap: () => Get.to(PengumumanPegawaiDetail(
                                          id: _pengumumanController
                                              .pengumuman.value[index].id,
                                        )),
                                    iconData: Icons.search),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.schedule,
                                      size: 16,
                                    )),
                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.clip,
                                    text: TextSpan(
                                        style: textBlack,
                                        text: formatter.format(DateTime.parse(
                                            _pengumumanController.pengumuman
                                                .value[index].tanggal))),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}

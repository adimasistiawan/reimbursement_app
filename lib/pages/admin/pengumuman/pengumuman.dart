import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siepegawai/circle.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/pengumumancontroller.dart';
import 'package:siepegawai/pages/admin/pegawai/pegawaidetail.dart';
import 'package:siepegawai/pages/admin/pegawai/tambahpegawai.dart';
import 'package:siepegawai/pages/admin/pengumuman/pengumumandetail.dart';
import 'package:siepegawai/pages/admin/pengumuman/tambah.dart';
import 'package:siepegawai/theme.dart';

class PengumumanPage extends StatefulWidget {
  @override
  _PengumumanPageState createState() => _PengumumanPageState();
}

class _PengumumanPageState extends State<PengumumanPage> {
  PengumumanController _pengumumanController = Get.put(PengumumanController());
  @override
  void initState() {
    _pengumumanController.getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
          backgroundColor: navy,
          title: Text(
            "Pengumuman",
            style: textWhite3,
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(TambahPengumuman());
        },
        label: Text(
          'Tambah',
          style: textWhite2,
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: navy,
      ),
      body: Container(
        height: size.height,
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
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              _pengumumanController.pengumuman.value.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              height: 70,
                              padding: EdgeInsets.only(
                                  top: 10, left: 18, right: 24, bottom: 10),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 250,
                                        child: Flexible(
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              style: textBlack2Bold,
                                              text: _pengumumanController
                                                  .pengumuman
                                                  .value[index]
                                                  .judul,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.to(PengumumanDetail(
                                          id: _pengumumanController
                                              .pengumuman.value[index].id,
                                        )),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Lihat",
                                                  style: textBlack,
                                                ),
                                                Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  size: 24,
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              text: formatter.format(
                                                  DateTime.parse(
                                                      _pengumumanController
                                                          .pengumuman
                                                          .value[index]
                                                          .tanggal))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }
}

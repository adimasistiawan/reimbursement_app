import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/cuticontroller.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/pages/admin/reimbursement/detail.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/detail.dart';
import 'package:siepegawai/theme.dart';

class CutiTelahPegawai extends StatelessWidget {
  const CutiTelahPegawai({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CutiController _cutiController = Get.put(CutiController());
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Obx(() => _cutiController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _cutiController.getDataAll(),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _cutiController.telah.value.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: _cutiController.telah.length == 0
                        ? Container(
                            child: Center(
                              child: Text(
                                "Kosong",
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: 230,
                            padding: EdgeInsets.only(
                                top: 18, left: 18, right: 10, bottom: 18),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 5,
                                            left: 10,
                                            right: 10,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          _cutiController
                                              .telah.value[index].kode,
                                          style: textBlack2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 5,
                                            left: 10,
                                            right: 10,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          color: _cutiController.telah
                                                      .value[index].status ==
                                                  "Belum Dikonfirmasi"
                                              ? Colors.yellow[700]
                                              : _cutiController
                                                          .telah
                                                          .value[index]
                                                          .status ==
                                                      "Telah Diterima"
                                                  ? Colors.green[300]
                                                  : Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          _cutiController
                                              .telah.value[index].status,
                                          style: textWhite2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(Icons.person)),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          style: textBlack3,
                                          text: _cutiController
                                              .telah.value[index].nama,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child:
                                            Icon(Icons.calendar_today_rounded)),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.clip,
                                        text: TextSpan(
                                            style: textBlack2,
                                            text: formatter.format(
                                                DateTime.parse(_cutiController
                                                    .telah
                                                    .value[index]
                                                    .tanggalPengajuan))),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.clip,
                                    text: TextSpan(
                                        style: textBlack2,
                                        text: "Cuti Dari " +
                                            formatter.format(DateTime.parse(
                                                _cutiController
                                                    .telah.value[index].dari)) +
                                            " Sampai " +
                                            formatter.format(DateTime.parse(
                                                _cutiController.telah
                                                    .value[index].sampai))),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: _cutiController
                                              .telah.value[index].status !=
                                          "Belum Dikonfirmasi",
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child:
                                                  Text("Dikonfirmasi pada :")),
                                          Container(
                                              child: Text(
                                            _cutiController.telah.value[index]
                                                        .tanggalKonfirmasi ==
                                                    null
                                                ? "-"
                                                : formatter.format(DateTime
                                                    .parse(_cutiController
                                                        .telah
                                                        .value[index]
                                                        .tanggalKonfirmasi)),
                                            style: textBlack2,
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                  );
                },
              ),
            )),
    );
  }
}

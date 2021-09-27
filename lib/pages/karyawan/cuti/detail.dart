import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/cuticontroller.dart';
import 'package:siepegawai/imagepreview.dart';
import 'package:siepegawai/pages/karyawan/cuti/edit.dart';
import 'package:siepegawai/theme.dart';

class CutiDetailPegawaiPage extends StatefulWidget {
  @override
  int id;
  CutiDetailPegawaiPage({this.id});
  _CutiDetailPegawaiPageState createState() => _CutiDetailPegawaiPageState();
}

class _CutiDetailPegawaiPageState extends State<CutiDetailPegawaiPage> {
  CutiController _cutiController = Get.put(CutiController());
  @override
  void initState() {
    _cutiController.getDetail(widget.id);
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
              "Detail Cuti",
              style: textWhite3,
            )),
        body: Obx(() => _cutiController.isLoading2.value
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: size.height,
                padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 18, left: 18, right: 18, bottom: 18),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
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
                              Text(
                                _cutiController.detail.value.kode,
                                style: textBlack3Bold,
                              ),
                            ],
                          ),
                          Row(
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
                                          _cutiController
                                              .detail.value.tanggalPengajuan))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: RichText(
                              overflow: TextOverflow.clip,
                              text: TextSpan(
                                  style: textBlack2,
                                  text: "Cuti Dari " +
                                      formatterdate.format(DateTime.parse(
                                          _cutiController.detail.value.dari)) +
                                      " Sampai " +
                                      formatterdate.format(DateTime.parse(
                                          _cutiController
                                              .detail.value.sampai))),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Text(
                              _cutiController.detail.value.status,
                              style: _cutiController.detail.value.status ==
                                      "Belum Dikonfirmasi"
                                  ? textYellow2Bold
                                  : _cutiController.detail.value.status ==
                                          "Telah Diterima"
                                      ? textGreen2Bold
                                      : textRed2Bold,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Visibility(
                                visible: _cutiController.detail.value.status !=
                                    "Belum Dikonfirmasi",
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Text(
                                      "Dikonfirmasi pada : ",
                                      style: textBlack,
                                    )),
                                    Container(
                                        child: Text(
                                      _cutiController.detail.value
                                                  .tanggalKonfirmasi ==
                                              null
                                          ? "-"
                                          : formatter.format(DateTime.parse(
                                              _cutiController.detail.value
                                                  .tanggalKonfirmasi)),
                                      style: textBlack,
                                    )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 18, left: 18, right: 18, bottom: 18),
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
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
                                Text(
                                  "Alasan",
                                  style: textBlack2Bold,
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                _cutiController.detail.value.alasan,
                                style: textBlack2,
                              ),
                            ),
                          ]),
                    ),
                    Visibility(
                      visible: _cutiController.detail.value.status == "Ditolak",
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 18, left: 18, right: 18, bottom: 18),
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Alasan Ditolak",
                                    style: textRed2Bold,
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  _cutiController.detail.value.alasanDitolak ==
                                          null
                                      ? "-"
                                      : _cutiController
                                          .detail.value.alasanDitolak,
                                  style: textBlack2,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Visibility(
                      visible: _cutiController.detail.value.status ==
                          "Belum Dikonfirmasi",
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10),
                            child: MaterialButton(
                                color: Colors.green[400],
                                splashColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Ubah',
                                  style: textWhite2,
                                ),
                                onPressed: () {
                                  Get.to(UbahCuti());
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Tidak"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ya"),
      onPressed: () {
        _cutiController.delete(_cutiController.detail.value.id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Apakah kamu yakin ingin menghapus data ini?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

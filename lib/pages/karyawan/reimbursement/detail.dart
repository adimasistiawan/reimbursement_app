import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/imagepreview.dart';
import 'package:siepegawai/pages/admin/reimbursement/history.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/edit.dart';
import 'package:siepegawai/theme.dart';

class ReimbursementDetailPegawaiPage extends StatefulWidget {
  @override
  int id;
  ReimbursementDetailPegawaiPage({this.id});
  _ReimbursementDetailPegawaiPageState createState() =>
      _ReimbursementDetailPegawaiPageState();
}

class _ReimbursementDetailPegawaiPageState
    extends State<ReimbursementDetailPegawaiPage> {
  ReimbursementController _reimbursementController =
      Get.put(ReimbursementController());
  @override
  void initState() {
    _reimbursementController.getDetail(widget.id);
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
              "Detail Reimbursement",
              style: textWhite3,
            )),
        body: Obx(() => _reimbursementController.isLoading2.value
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
                                _reimbursementController.detail.value.kode,
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
                                          _reimbursementController
                                              .detail.value.tanggalPengajuan))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Nominal : Rp. " +
                                number_format
                                    .format(_reimbursementController
                                        .detail.value.nominal)
                                    .toString(),
                            style: textBlack2,
                          ),
                          // Visibility(
                          //   visible:
                          //       _reimbursementController.detail.value.status ==
                          //           "Ditolak",
                          //   child: Text(
                          //     "Alasan Ditolak :",
                          //     style: textBlack2,
                          //   ),
                          // ),
                          // Visibility(
                          //   visible:
                          //       _reimbursementController.detail.value.status ==
                          //           "Ditolak",
                          //   child: Text(
                          //     _reimbursementController
                          //                 .detail.value.alasanDitolak ==
                          //             null
                          //         ? "-"
                          //         : _reimbursementController
                          //             .detail.value.alasanDitolak,
                          //     style: textBlack2,
                          //   ),
                          // ),

                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Text(
                              _reimbursementController.detail.value.status,
                              style: _reimbursementController
                                          .detail.value.status ==
                                      "Belum Dikonfirmasi"
                                  ? textYellow2Bold
                                  : _reimbursementController
                                              .detail.value.status ==
                                          "Telah Diterima"
                                      ? textGreen2Bold
                                      : textRed2Bold,
                            ),
                          ),

                          Row(
                            children: [
                              Visibility(
                                visible: _reimbursementController
                                        .detail.value.status !=
                                    "Belum Dikonfirmasi",
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(
                                        "Dikonfirmasi pada : ",
                                        style: textBlack,
                                      )),
                                      Container(
                                          child: Text(
                                        _reimbursementController.detail.value
                                                    .tanggalKonfirmasi ==
                                                null
                                            ? "-"
                                            : formatter.format(DateTime.parse(
                                                _reimbursementController.detail
                                                    .value.tanggalKonfirmasi)),
                                        style: textBlack,
                                      )),
                                    ],
                                  ),
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
                                  "Keterangan",
                                  style: textBlack2Bold,
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                _reimbursementController
                                    .detail.value.keterangan,
                                style: textBlack2,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: FlatButton(
                                onPressed: () => Get.to(ImagePreview(
                                  image: asset_url +
                                      _reimbursementController
                                          .detail.value.buktiPembayaran,
                                )),
                                child: Text('Lihat Bukti Pembayaran',
                                    style: TextStyle(color: Colors.blue)),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.blue,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ]),
                    ),
                    Visibility(
                      visible: _reimbursementController.detail.value.status ==
                          "Ditolak",
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
                                  _reimbursementController
                                              .detail.value.alasanDitolak ==
                                          null
                                      ? "-"
                                      : _reimbursementController
                                          .detail.value.alasanDitolak,
                                  style: textBlack2,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Visibility(
                      visible: _reimbursementController.detail.value.status ==
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
                                  Get.to(UbahReimbursement());
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
        _reimbursementController
            .deleteReimbursement(_reimbursementController.detail.value.id);
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

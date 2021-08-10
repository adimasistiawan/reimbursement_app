import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/imagepreview.dart';
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
  DateFormat formatter = DateFormat("dd-MM-yyyy");
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
                              Container(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
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
                                  child: Text(
                                    _reimbursementController.detail.value.kode,
                                    style: textBlack2,
                                  ),
                                ),
                              ),
                              Container(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5),
                                  decoration: BoxDecoration(
                                    color: _reimbursementController
                                                .detail.value.status ==
                                            "Belum Dikonfirmasi"
                                        ? Colors.yellow[700]
                                        : _reimbursementController
                                                    .detail.value.status ==
                                                "Telah Diterima"
                                            ? Colors.green[300]
                                            : Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
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
                                  child: Text(
                                    _reimbursementController
                                        .detail.value.status,
                                    style: textWhite2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
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
                                    text: _reimbursementController
                                        .detail.value.nama,
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
                                  child: Icon(Icons.calendar_today_rounded)),
                              Flexible(
                                child: RichText(
                                  overflow: TextOverflow.clip,
                                  text: TextSpan(
                                      style: textBlack2,
                                      text: formatter.format(DateTime.parse(
                                          _reimbursementController
                                              .detail.value.tanggalPengajuan))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Nominal : Rp. " +
                                number_format
                                    .format(_reimbursementController
                                        .detail.value.nominal)
                                    .toString(),
                            style: textBlack2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Visibility(
                                visible: _reimbursementController
                                        .detail.value.status !=
                                    "Belum Dikonfirmasi",
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Text(
                                      "Dikonfirmasi pada : ",
                                      style: textBlack2,
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
                                      style: textBlack2,
                                    )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Keterangan :",
                            style: textBlack2,
                          ),
                          Text(
                            _reimbursementController.detail.value.keterangan,
                            style: textBlack2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible:
                                _reimbursementController.detail.value.status ==
                                    "Ditolak",
                            child: Text(
                              "Alasan Ditolak :",
                              style: textBlack2,
                            ),
                          ),
                          Visibility(
                            visible:
                                _reimbursementController.detail.value.status ==
                                    "Ditolak",
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
                          SizedBox(
                            height: 20,
                          ),
                          FlatButton(
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
                        ],
                      ),
                    ),
                  ],
                ),
              )));
  }
}

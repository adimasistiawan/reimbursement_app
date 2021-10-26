import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:siepegawai/circle.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/pegawaicontroller.dart';
import 'package:siepegawai/controllers/cuticontroller.dart';
import 'package:siepegawai/pages/admin/pegawai/ubahpegawai.dart';
import 'package:siepegawai/pages/admin/cuti/detail.dart';
import 'package:siepegawai/theme.dart';

class FilterStatus extends StatefulWidget {
  int id;
  FilterStatus({this.id});
  @override
  _FilterStatusState createState() => _FilterStatusState();
}

class _FilterStatusState extends State<FilterStatus> {
  CutiController _cutiController = Get.put(CutiController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      height: MediaQuery.of(context).size.height * .30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Filter Status",
                style: textBlack3Bold,
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 25,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _cutiController.selectedstatus = 1;
                      _cutiController.status = "Semua";
                    });
                    _cutiController.getHistoryFilter(widget.id);
                    Get.back();
                  },
                  child: Text('Semua',
                      style: TextStyle(
                          color: _cutiController.selectedstatus == 1
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11)),
                  color: _cutiController.selectedstatus == 1
                      ? Colors.green
                      : Colors.white,
                  textColor: _cutiController.selectedstatus == 1
                      ? Colors.white
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: _cutiController.selectedstatus == 1
                              ? Colors.green
                              : Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _cutiController.selectedstatus = 2;
                      _cutiController.status = "Telah Diterima";
                    });
                    _cutiController.getHistoryFilter(widget.id);
                    Get.back();
                  },
                  child: Text('Telah Diterima',
                      style: TextStyle(
                          color: _cutiController.selectedstatus == 2
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11)),
                  color: _cutiController.selectedstatus == 2
                      ? Colors.green
                      : Colors.white,
                  textColor: _cutiController.selectedstatus == 2
                      ? Colors.white
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: _cutiController.selectedstatus == 2
                              ? Colors.green
                              : Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _cutiController.selectedstatus = 3;
                      _cutiController.status = "Ditolak";
                    });
                    _cutiController.getHistoryFilter(widget.id);
                    Get.back();
                  },
                  child: Text('Ditolak',
                      style: TextStyle(
                          color: _cutiController.selectedstatus == 3
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11)),
                  color: _cutiController.selectedstatus == 3
                      ? Colors.green
                      : Colors.white,
                  textColor: _cutiController.selectedstatus == 3
                      ? Colors.white
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: _cutiController.selectedstatus == 3
                              ? Colors.green
                              : Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _cutiController.selectedstatus = 4;
                  _cutiController.status = "Belum Dikonfirmasi";
                });
                _cutiController.getHistoryFilter(widget.id);
                Get.back();
              },
              child: Text('Belum Dikonfirmasi',
                  style: TextStyle(
                      color: _cutiController.selectedstatus == 4
                          ? Colors.white
                          : Colors.black,
                      fontSize: 11)),
              color: _cutiController.selectedstatus == 4
                  ? Colors.green
                  : Colors.white,
              textColor: _cutiController.selectedstatus == 4
                  ? Colors.white
                  : Colors.black,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: _cutiController.selectedstatus == 4
                          ? Colors.green
                          : Colors.black,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),

          // Container(
          //   width: MediaQuery.of(context).size.width * 0.40,
          //   child: DropdownButtonFormField(
          //     style: textGrey3,
          //     decoration: InputDecoration(),
          //     value: _cutiController.status,
          //     items: status.map((value) {
          //       return DropdownMenuItem(
          //         child: Text(
          //           value,
          //           style: textBlack,
          //         ),
          //         value: value,
          //       );
          //     }).toList(),
          //     onChanged: (value) {
          //       setState(() {
          //         _cutiController.status = value;
          //       });
          //       _cutiController.getHistoryFilter(widget.id);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class HistoryCuti extends StatefulWidget {
  @override
  int id;
  HistoryCuti({this.id});
  _HistoryCutiState createState() => _HistoryCutiState();
}

class _HistoryCutiState extends State<HistoryCuti> {
  CutiController _cutiController = Get.put(CutiController());
  PegawaiController _pegawaiController = Get.put(PegawaiController());
  @override
  void initState() {
    _cutiController.getHistory(widget.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    DateTime dari = DateTime.now();
    DateTime sampai = DateTime.now();
    DateFormat formatterinput = DateFormat("yyyy-MM-dd");
    String statusval = 'Semua';
    List status = [
      "Semua",
      "Belum Dikonfirmasi",
      "Telah Diterima",
      "Ditolak",
    ];
    void filter_status(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return FilterStatus(
              id: widget.id,
            );
          });
    }

    showAlertDialog(BuildContext context) {
      final GlobalKey<FormState> formkey = GlobalKey<FormState>();
      // set up the buttons
      Alert(
          context: context,
          title: "Filter",
          content: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        theme: DatePickerTheme(
                            headerColor: Colors.white,
                            backgroundColor: Colors.blue,
                            itemStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            cancelStyle: TextStyle(color: Colors.red),
                            doneStyle:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        onCancel: () {
                      _cutiController.daritanggal.text = "";
                    }, onChanged: (date) {
                      // print('change $date in time zone ' +
                      //     date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      setState(() {
                        dari = date;
                        print(dari);
                        _cutiController.daritanggal.text = formatterinput
                            .format(DateTime.parse(date.toString()));
                      });
                      print('confirm $date');
                    }, currentTime: dari, locale: LocaleType.id);
                  },
                  maxLines: null,
                  readOnly: true,
                  controller: _cutiController.daritanggal,
                  decoration: InputDecoration(
                    labelText: "Dari Tanggal",
                  ),
                  validator: (value) {
                    return value.trim().isEmpty &&
                            _cutiController.sampaitanggal.text != ''
                        ? 'Mohon masukan tanggal'
                        : null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        theme: DatePickerTheme(
                            cancelStyle: TextStyle(color: Colors.red),
                            headerColor: Colors.white,
                            backgroundColor: Colors.blue,
                            itemStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        onCancel: () {
                      _cutiController.sampaitanggal.text = "";
                    }, onChanged: (date) {
                      // print('change $date in time zone ' +
                      //     date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      setState(() {
                        sampai = date;
                        _cutiController.sampaitanggal.text = formatterinput
                            .format(DateTime.parse(date.toString()));
                      });
                      print('confirm $date');
                    }, currentTime: sampai, locale: LocaleType.id);
                  },
                  maxLines: null,
                  readOnly: true,
                  controller: _cutiController.sampaitanggal,
                  decoration: InputDecoration(
                    labelText: "Sampai Tanggal",
                  ),
                  validator: (value) {
                    return value.trim().isEmpty &&
                            _cutiController.daritanggal.text != ''
                        ? 'Mohon masukan tanggal'
                        : null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _cutiController.kode,
                  decoration: InputDecoration(
                    labelText: "Kode",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          buttons: [
            DialogButton(
              onPressed: () {
                if (formkey.currentState.validate()) {
                  _cutiController.getHistoryFilter(widget.id);
                  Get.back();
                }
              },
              child: Text(
                "Cari",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }

    return Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
            backgroundColor: navy,
            title: Text(
              "Riwayat Cuti",
              style: textWhite3,
            )),
        body: Container(
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 5, right: 18, left: 18),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: textWhite2Bold,
                            text: _pegawaiController.user.value.nama,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                              style: textWhite2Bold,
                              text: _pegawaiController.user.value.divisi),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(top: 18, right: 10, left: 18),
                      child: MaterialButton(
                          color: navy,
                          splashColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Pencarian',
                                style: textWhite2,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Icon(
                                  Icons.search,
                                  color: white,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            showAlertDialog(context);
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 15, top: 18),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: FlatButton(
                        onPressed: () {
                          filter_status(context);
                        },
                        child: Text('Filter Status',
                            style: TextStyle(color: Colors.blue, fontSize: 13)),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.blue,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    right: 18,
                    left: 18,
                  ),
                  child: Obx(() => _cutiController.isLoading3.value
                      ? Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: () => _cutiController.getDataAll(),
                          child: _cutiController.history.length == 0
                              ? Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                  itemCount:
                                      _cutiController.history.value.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: double.infinity,
                                      height: _cutiController.history
                                                  .value[index].status ==
                                              "Belum Dikonfirmasi"
                                          ? 150
                                          : 180,
                                      padding: EdgeInsets.only(
                                          top: 18,
                                          left: 18,
                                          right: 24,
                                          bottom: 18),
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _cutiController
                                                    .history.value[index].kode,
                                                style: textBlack3Bold,
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    Get.to(CutiDetailPage(
                                                  id: _cutiController
                                                      .history.value[index].id,
                                                )),
                                                child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
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
                                                          Icons
                                                              .remove_red_eye_outlined,
                                                          size: 24,
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
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
                                                              _cutiController
                                                                  .history
                                                                  .value[index]
                                                                  .tanggalPengajuan))),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.clip,
                                              text: TextSpan(
                                                  style: textBlack2,
                                                  text: "Cuti Dari " +
                                                      formatterdate.format(
                                                          DateTime.parse(
                                                              _cutiController
                                                                  .history
                                                                  .value[index]
                                                                  .dari)) +
                                                      " Sampai " +
                                                      formatterdate.format(
                                                          DateTime.parse(
                                                              _cutiController
                                                                  .history
                                                                  .value[index]
                                                                  .sampai))),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Text(
                                              _cutiController
                                                  .history.value[index].status,
                                              style: _cutiController
                                                          .history
                                                          .value[index]
                                                          .status ==
                                                      "Belum Dikonfirmasi"
                                                  ? textYellow2Bold
                                                  : _cutiController
                                                              .history
                                                              .value[index]
                                                              .status ==
                                                          "Telah Diterima"
                                                      ? textGreen2Bold
                                                      : textRed2Bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Visibility(
                                                visible: _cutiController.history
                                                        .value[index].status !=
                                                    "Belum Dikonfirmasi",
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Dikonfirmasi pada :",
                                                      style: textBlack,
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5),
                                                        child: Text(
                                                          _cutiController
                                                                      .history
                                                                      .value[
                                                                          index]
                                                                      .tanggalKonfirmasi ==
                                                                  null
                                                              ? "-"
                                                              : formatter.format(DateTime.parse(
                                                                  _cutiController
                                                                      .history
                                                                      .value[
                                                                          index]
                                                                      .tanggalKonfirmasi)),
                                                          style: textBlack,
                                                        )),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        )),
                ),
              ),
            ],
          ),
        ));
  }
}

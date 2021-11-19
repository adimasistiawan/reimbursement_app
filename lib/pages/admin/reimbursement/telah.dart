import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:siepegawai/circle.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/pages/admin/reimbursement/detail.dart';
import 'package:siepegawai/theme.dart';

class FilterStatus extends StatefulWidget {
  const FilterStatus({Key key}) : super(key: key);

  @override
  _FilterStatusState createState() => _FilterStatusState();
}

class _FilterStatusState extends State<FilterStatus> {
  ReimbursementController _reimbursementController =
      Get.put(ReimbursementController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      height: MediaQuery.of(context).size.height * .23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            height: 30,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _reimbursementController.selectedstatus = 1;
                      _reimbursementController.status = "Semua";
                    });
                    _reimbursementController.getDataAllFilter();
                    Get.back();
                  },
                  child: Text('Semua',
                      style: TextStyle(
                          color: _reimbursementController.selectedstatus == 1
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11)),
                  color: _reimbursementController.selectedstatus == 1
                      ? Colors.green
                      : Colors.white,
                  textColor: _reimbursementController.selectedstatus == 1
                      ? Colors.white
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: _reimbursementController.selectedstatus == 1
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
                      _reimbursementController.selectedstatus = 2;
                      _reimbursementController.status = "Telah Diterima";
                    });
                    _reimbursementController.getDataAllFilter();
                    Get.back();
                  },
                  child: Text('Telah Diterima',
                      style: TextStyle(
                          color: _reimbursementController.selectedstatus == 2
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11)),
                  color: _reimbursementController.selectedstatus == 2
                      ? Colors.green
                      : Colors.white,
                  textColor: _reimbursementController.selectedstatus == 2
                      ? Colors.white
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: _reimbursementController.selectedstatus == 2
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
                      _reimbursementController.selectedstatus = 3;
                      _reimbursementController.status = "Ditolak";
                    });
                    _reimbursementController.getDataAllFilter();
                    Get.back();
                  },
                  child: Text('Ditolak',
                      style: TextStyle(
                          color: _reimbursementController.selectedstatus == 3
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11)),
                  color: _reimbursementController.selectedstatus == 3
                      ? Colors.green
                      : Colors.white,
                  textColor: _reimbursementController.selectedstatus == 3
                      ? Colors.white
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: _reimbursementController.selectedstatus == 3
                              ? Colors.green
                              : Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.40,
          //   child: DropdownButtonFormField(
          //     style: textGrey3,
          //     decoration: InputDecoration(),
          //     value: _reimbursementController.status,
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
          //         _reimbursementController.status = value;
          //       });
          //       _reimbursementController.getDataAllFilter();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ReimbursementTelahAdmin extends StatefulWidget {
  const ReimbursementTelahAdmin({Key key}) : super(key: key);

  @override
  _ReimbursementTelahAdminState createState() =>
      _ReimbursementTelahAdminState();
}

class _ReimbursementTelahAdminState extends State<ReimbursementTelahAdmin> {
  ScrollController _scrollcontroller = ScrollController();
  int _currentMax = 4;
  bool isProgress = false;
  @override
  void initState() {
    _scrollcontroller.addListener(() {
      if (_scrollcontroller.position.pixels ==
          _scrollcontroller.position.maxScrollExtent) {
        print("test");
        setState(() {
          isProgress = true;
        });
        Timer(const Duration(seconds: 2), () {
          addList();
          setState(() {
            isProgress = false;
          });
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  addList() {
    _currentMax += 4;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ReimbursementController _reimbursementController =
        Get.put(ReimbursementController());
    var size = MediaQuery.of(context).size;
    DateTime dari = DateTime.now();
    DateTime sampai = DateTime.now();
    DateFormat formatterinput = DateFormat("yyyy-MM-dd");
    String statusval = 'Semua';
    List status = [
      "Semua",
      "Telah Diterima",
      "Ditolak",
    ];

    void filter_status(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return FilterStatus();
          });
    }

    showAlertDialog(BuildContext context) {
      final GlobalKey<FormState> formkey = GlobalKey<FormState>();
      // set up the buttons
      Alert(
          context: context,
          title: "Pencarian",
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
                      _reimbursementController.daritanggal.text = "";
                    }, onChanged: (date) {
                      // print('change $date in time zone ' +
                      //     date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      setState(() {
                        dari = date;
                        print(dari);
                        _reimbursementController.daritanggal.text =
                            formatterinput
                                .format(DateTime.parse(date.toString()));
                      });
                      print('confirm $date');
                    }, currentTime: dari, locale: LocaleType.id);
                  },
                  maxLines: null,
                  readOnly: true,
                  controller: _reimbursementController.daritanggal,
                  decoration: InputDecoration(
                    labelText: "Dari Tanggal",
                  ),
                  validator: (value) {
                    return value.trim().isEmpty &&
                            _reimbursementController.sampaitanggal.text != ''
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
                      _reimbursementController.sampaitanggal.text = "";
                    }, onChanged: (date) {
                      // print('change $date in time zone ' +
                      //     date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      setState(() {
                        sampai = date;
                        _reimbursementController.sampaitanggal.text =
                            formatterinput
                                .format(DateTime.parse(date.toString()));
                      });
                      print('confirm $date');
                    }, currentTime: sampai, locale: LocaleType.id);
                  },
                  maxLines: null,
                  readOnly: true,
                  controller: _reimbursementController.sampaitanggal,
                  decoration: InputDecoration(
                    labelText: "Sampai Tanggal",
                  ),
                  validator: (value) {
                    return value.trim().isEmpty &&
                            _reimbursementController.daritanggal.text != ''
                        ? 'Mohon masukan tanggal'
                        : null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _reimbursementController.kode,
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
                  _reimbursementController.getDataAllFilter();
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

    return Container(
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
              child: Obx(() => _reimbursementController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => _reimbursementController.getDataAll(),
                      child: _reimbursementController.telah.length == 0
                          ? Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                              physics: BouncingScrollPhysics(),
                              controller: _scrollcontroller,
                              shrinkWrap: true,
                              itemCount:
                                  _reimbursementController.telah.value.length <
                                          _currentMax
                                      ? _reimbursementController
                                              .telah.value.length +
                                          1
                                      : _currentMax + 1,
                              itemBuilder: (context, index) {
                                if (index ==
                                    (_reimbursementController
                                                .telah.value.length <
                                            _currentMax
                                        ? _reimbursementController
                                            .telah.value.length
                                        : _currentMax)) {
                                  return Visibility(
                                    visible: isProgress,
                                    child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())),
                                  );
                                }
                                return Container(
                                  width: double.infinity,
                                  height: 220,
                                  padding: EdgeInsets.only(
                                      top: 18, left: 18, right: 24, bottom: 18),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _reimbursementController
                                                .telah.value[index].kode,
                                            style: textBlack3Bold,
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                Get.to(ReimbursementDetailPage(
                                              id: _reimbursementController
                                                  .telah.value[index].id,
                                            )),
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 3),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                          _reimbursementController
                                                              .telah
                                                              .value[index]
                                                              .tanggalPengajuan))),
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
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.blue[800],
                                              )),
                                          Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                style: textBlue2Bold,
                                                text: _reimbursementController
                                                    .telah.value[index].nama,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.clip,
                                          text: TextSpan(
                                              style: textBlack2,
                                              text: "Nominal : Rp. " +
                                                  number_format
                                                      .format(
                                                          _reimbursementController
                                                              .telah
                                                              .value[index]
                                                              .nominal)
                                                      .toString()),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: Text(
                                          _reimbursementController
                                              .telah.value[index].status,
                                          style: _reimbursementController.telah
                                                      .value[index].status ==
                                                  "Belum Dikonfirmasi"
                                              ? textYellow2Bold
                                              : _reimbursementController
                                                          .telah
                                                          .value[index]
                                                          .status ==
                                                      "Telah Diterima"
                                                  ? textGreen2Bold
                                                  : textRed2Bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: _reimbursementController
                                                    .telah
                                                    .value[index]
                                                    .status !=
                                                "Belum Dikonfirmasi",
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Dikonfirmasi pada :"),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    child: Text(
                                                      _reimbursementController
                                                                  .telah
                                                                  .value[index]
                                                                  .tanggalKonfirmasi ==
                                                              null
                                                          ? "-"
                                                          : formatter.format(
                                                              DateTime.parse(
                                                                  _reimbursementController
                                                                      .telah
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
    );
  }
}

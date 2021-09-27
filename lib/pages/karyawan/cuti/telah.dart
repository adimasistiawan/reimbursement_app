import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:siepegawai/circle.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/cuticontroller.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/pages/admin/reimbursement/detail.dart';
import 'package:siepegawai/pages/karyawan/cuti/detail.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/detail.dart';
import 'package:siepegawai/theme.dart';

class CutiTelahPegawai extends StatefulWidget {
  const CutiTelahPegawai({Key key}) : super(key: key);

  @override
  _CutiTelahPegawaiState createState() => _CutiTelahPegawaiState();
}

class _CutiTelahPegawaiState extends State<CutiTelahPegawai> {
  @override
  Widget build(BuildContext context) {
    CutiController _cutiController = Get.put(CutiController());
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
                  _cutiController.getDataUserFilter();
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
          Container(
            child: Container(
              padding: EdgeInsets.only(top: 18, right: 18, left: 18),
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
                        'Filter',
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
          Container(
            width: MediaQuery.of(context).size.width * 0.40,
            padding: EdgeInsets.only(right: 18, left: 18),
            child: DropdownButtonFormField(
              style: textGrey3,
              decoration: InputDecoration(),
              value: _cutiController.status,
              items: status.map((value) {
                return DropdownMenuItem(
                  child: Text(
                    value,
                    style: textBlack,
                  ),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _cutiController.status = value;
                });
                _cutiController.getDataUserFilter();
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
              child: Obx(() => _cutiController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => _cutiController.getDataUser()(),
                      child: _cutiController.telah.length == 0
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
                              itemCount: _cutiController.telah.value.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  height: 180,
                                  padding: EdgeInsets.only(
                                      top: 10, left: 18, right: 24, bottom: 18),
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
                                            _cutiController
                                                .telah.value[index].kode,
                                            style: textBlack3Bold,
                                          ),
                                          CircleButton(
                                              onTap: () =>
                                                  Get.to(CutiDetailPegawaiPage(
                                                    id: _cutiController
                                                        .telah.value[index].id,
                                                  )),
                                              iconData: Icons.search),
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
                                                  text: formatter.format(DateTime
                                                      .parse(_cutiController
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
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.clip,
                                          text: TextSpan(
                                              style: textBlack2,
                                              text: "Cuti Dari " +
                                                  formatterdate.format(
                                                      DateTime.parse(
                                                          _cutiController
                                                              .telah
                                                              .value[index]
                                                              .dari)) +
                                                  " Sampai " +
                                                  formatterdate.format(
                                                      DateTime.parse(
                                                          _cutiController
                                                              .telah
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
                                              .telah.value[index].status,
                                          style: _cutiController.telah
                                                      .value[index].status ==
                                                  "Belum Dikonfirmasi"
                                              ? textYellow2Bold
                                              : _cutiController
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
                                            visible: _cutiController.telah
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
                                                                  .telah
                                                                  .value[index]
                                                                  .tanggalKonfirmasi ==
                                                              null
                                                          ? "-"
                                                          : formatter.format(
                                                              DateTime.parse(
                                                                  _cutiController
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

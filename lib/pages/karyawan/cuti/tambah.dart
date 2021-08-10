import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/cuticontroller.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/theme.dart';

class TambahCuti extends StatefulWidget {
  @override
  _TambahCutiState createState() => _TambahCutiState();
}

class _TambahCutiState extends State<TambahCuti> {
  CutiController _controller = Get.put(CutiController());
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DateTime dari = DateTime.now();
  DateTime sampai = DateTime.now();
  @override
  void initState() {
    _controller.alasan.text = '';
    _controller.dari.text = '';
    _controller.sampai.text = '';

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    DateFormat formatterinput = DateFormat("yyyy-MM-dd");

    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
          backgroundColor: navy,
          title: Text(
            "Buat Pengajuan Cuti",
            style: textWhite3,
          )),
      body: Container(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              // OutlineButton(
              //   color: Colors.blue,
              //   onPressed: chooseImage,
              //   child: Text('Masukan Foto Bukti Pembayaran'),
              // ),

              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Dari Tanggal",
                  style: textBlack3,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        theme: DatePickerTheme(
                            headerColor: Colors.orange,
                            backgroundColor: Colors.blue,
                            itemStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onChanged: (date) {
                      // print('change $date in time zone ' +
                      //     date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      setState(() {
                        dari = date;
                        print(dari);
                        _controller.dari.text = formatterinput
                            .format(DateTime.parse(date.toString()));
                      });
                      print('confirm $date');
                    }, currentTime: dari, locale: LocaleType.id);
                  },
                  maxLines: null,
                  readOnly: true,
                  controller: _controller.dari,
                  decoration: InputDecoration(
                      hintText: "Masukan Tanggal",
                      hintStyle: textGrey3,
                      border: InputBorder.none),
                  validator: (value) {
                    return value.trim().isEmpty
                        ? 'Mohon masukan tanggal'
                        : null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Sampai Tanggal",
                  style: textBlack3,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        theme: DatePickerTheme(
                            headerColor: Colors.orange,
                            backgroundColor: Colors.blue,
                            itemStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onChanged: (date) {
                      // print('change $date in time zone ' +
                      //     date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      setState(() {
                        sampai = date;
                        _controller.sampai.text = formatterinput
                            .format(DateTime.parse(date.toString()));
                      });
                      print('confirm $date');
                    }, currentTime: sampai, locale: LocaleType.id);
                  },
                  maxLines: null,
                  readOnly: true,
                  controller: _controller.sampai,
                  decoration: InputDecoration(
                      hintText: "Masukan Tanggal",
                      hintStyle: textGrey3,
                      border: InputBorder.none),
                  validator: (value) {
                    return value.trim().isEmpty
                        ? 'Mohon masukan tanggal'
                        : null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Alasan",
                  style: textBlack3,
                ),
              ),
              Container(
                height: 300,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _controller.alasan,
                  decoration: InputDecoration(
                      hintText: "Masukan Alasan",
                      hintStyle: textGrey3,
                      border: InputBorder.none),
                  validator: (value) {
                    return value.trim().isEmpty ? 'Mohon masukan alasan' : null;
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                      color: navy,
                      splashColor: Colors.white,
                      height: 45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Simpan',
                        style: textWhite2,
                      ),
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          print(dari);
                          if (dari.isAfter(sampai)) {
                            Get.dialog(AlertDialog(
                              content: Text(
                                  "Tanggal 'Dari' harus sebelum dari tanggal 'Sampai'"),
                              actions: [
                                FlatButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                )
                              ],
                            ));
                          } else {
                            _controller.create();
                          }
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

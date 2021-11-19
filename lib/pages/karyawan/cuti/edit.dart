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

class UbahCuti extends StatefulWidget {
  @override
  _UbahCutiState createState() => _UbahCutiState();
}

class _UbahCutiState extends State<UbahCuti> {
  CutiController _controller = Get.put(CutiController());
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    DateFormat formatterinput = DateFormat("yyyy-MM-dd");
    DateTime dari = DateTime.parse(_controller.detail.value.dari.toString());
    DateTime sampai =
        DateTime.parse(_controller.detail.value.sampai.toString());
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
          backgroundColor: navy,
          title: Text(
            "Ubah Pengajuan Cuti",
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

              TextFormField(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
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
                  labelText: "Dari Tanggal *",
                ),
                validator: (value) {
                  return value.trim().isEmpty ? 'Mohon masukan Tanggal' : null;
                },
              ),
              SizedBox(
                height: 15,
              ),

              TextFormField(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
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
                  labelText: "Sampai Tanggal *",
                ),
                validator: (value) {
                  return value.trim().isEmpty ? 'Mohon masukan Tanggal' : null;
                },
              ),
              SizedBox(
                height: 15,
              ),

              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: _controller.alasan,
                decoration: InputDecoration(
                  labelText: "Alasan *",
                ),
                validator: (value) {
                  return value.trim().isEmpty ? 'Mohon masukan Alasan' : null;
                },
              ),
              SizedBox(
                height: 30,
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
                            _controller
                                .updateDataCuti(_controller.detail.value.id);
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

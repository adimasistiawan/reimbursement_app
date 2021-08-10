import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/theme.dart';

class TambahReimbursement extends StatefulWidget {
  @override
  _TambahReimbursementState createState() => _TambahReimbursementState();
}

class _TambahReimbursementState extends State<TambahReimbursement> {
  ReimbursementController _controller = Get.put(ReimbursementController());
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller.ketarangan.text = '';
    _controller.nominal.text = '';
    // TODO: implement initState
    super.initState();
  }

  String base64Image;
  String status = '';
  File tmpFile;
  Future<File> file;

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              width: double.infinity * 0.50,
              height: 200,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'Mohon masukan foto yang jelas',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
          backgroundColor: navy,
          title: Text(
            "Buat Pengajuan Reimbursement",
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
              FlatButton(
                onPressed: () => chooseImage(),
                child: Text('Masukan Foto Bukti Pembayaran',
                    style: TextStyle(color: Colors.blue)),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blue, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(height: 100, child: showImage()),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Nominal",
                  style: textBlack3,
                ),
              ),
              Container(
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
                  controller: _controller.nominal,
                  decoration: InputDecoration(
                      hintText: "Masukan Nominal",
                      hintStyle: textGrey3,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    return value.trim().isEmpty
                        ? 'Mohon masukan Nominal'
                        : null;
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Keterangan",
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
                  controller: _controller.ketarangan,
                  decoration: InputDecoration(
                      hintText: "Masukan Keterangan",
                      hintStyle: textGrey3,
                      border: InputBorder.none),
                  validator: (value) {
                    return value.trim().isEmpty
                        ? 'Mohon masukan keterangan'
                        : null;
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
                          if (tmpFile != null) {
                            setState(() {
                              _controller.image = tmpFile;
                            });

                            _controller.create();
                          } else {
                            Get.dialog(AlertDialog(
                              content: Text("Mohon masukan foto"),
                              actions: [
                                FlatButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                )
                              ],
                            ));
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

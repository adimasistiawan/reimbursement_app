import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/imagepreviewstatic.dart';
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
          return GestureDetector(
            onTap: () => Get.to(ImagePreviewStatic(
              image: snapshot.data,
            )),
            child: Flexible(
              child: Image.file(
                snapshot.data,
                width: double.infinity * 0.50,
                height: 300,
              ),
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
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(height: 100, child: showImage()),
              SizedBox(
                height: 10,
              ),

              TextFormField(
                controller: _controller.nominal,
                decoration: InputDecoration(
                  labelText: "Nominal *",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  return value.trim().isEmpty
                      ? 'Mohon masukan Nominal'
                      : int.parse(value) > 150000
                          ? "Mohon masukan maksimal 150.000"
                          : null;
                },
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Maksimal 150.000",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 16,
              ),

              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: _controller.ketarangan,
                decoration: InputDecoration(labelText: "Keterangan *"),
                validator: (value) {
                  return value.trim().isEmpty
                      ? 'Mohon masukan keterangan'
                      : null;
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

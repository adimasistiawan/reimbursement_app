import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/controllers/pegawaicontroller.dart';
import 'package:siepegawai/controllers/pengumumancontroller.dart';
import 'package:siepegawai/theme.dart';

class UbahPengumuman extends StatefulWidget {
  @override
  _UbahPengumumanState createState() => _UbahPengumumanState();
}

class _UbahPengumumanState extends State<UbahPengumuman> {
  PengumumanController _controller = Get.put(PengumumanController());
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
          backgroundColor: navy,
          title: Text(
            "Ubah Pengumuman",
            style: textWhite3,
          )),
      body: Container(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Nama",
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
                  controller: _controller.judul,
                  decoration: InputDecoration(
                      hintText: "Masukan Judul",
                      hintStyle: textGrey3,
                      border: InputBorder.none),
                  validator: (value) {
                    return value.trim().isEmpty ? 'Mohon masukan Judul' : null;
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Isi",
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
                  controller: _controller.isi,
                  decoration: InputDecoration(
                      hintText: "Masukan Isi",
                      hintStyle: textGrey3,
                      border: InputBorder.none),
                  validator: (value) {
                    return value.trim().isEmpty
                        ? 'Mohon masukan Info Pembayaran'
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
                          _controller.updateData(_controller.detail.value.id);
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

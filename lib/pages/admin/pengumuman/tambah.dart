import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/controllers/pegawaicontroller.dart';
import 'package:siepegawai/controllers/pengumumancontroller.dart';
import 'package:siepegawai/theme.dart';

class TambahPengumuman extends StatefulWidget {
  @override
  _TambahPengumumanState createState() => _TambahPengumumanState();
}

class _TambahPengumumanState extends State<TambahPengumuman> {
  PengumumanController _controller = Get.put(PengumumanController());
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller.isi.text = '';
    _controller.judul.text = '';
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
            "Tambah Pengumuman",
            style: textWhite3,
          )),
      body: Container(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              TextFormField(
                controller: _controller.judul,
                decoration: InputDecoration(
                  labelText: "Judul *",
                ),
                validator: (value) {
                  return value.trim().isEmpty ? 'Mohon masukan Judul' : null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: _controller.isi,
                decoration: InputDecoration(
                  labelText: "Isi *",
                ),
                validator: (value) {
                  return value.trim().isEmpty ? 'Mohon masukan Isi' : null;
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
                          _controller.create();
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

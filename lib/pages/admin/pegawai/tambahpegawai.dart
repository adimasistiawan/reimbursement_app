import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/controllers/pegawaicontroller.dart';
import 'package:siepegawai/theme.dart';

class TambahPegawai extends StatefulWidget {
  @override
  _TambahPegawaiState createState() => _TambahPegawaiState();
}

class _TambahPegawaiState extends State<TambahPegawai> {
  PegawaiController _controller = Get.put(PegawaiController());
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String divisival;
  List divisi = [
    "IT Support",
    "Web Developer",
    "Mobile Developer",
    "Desktop Developer",
    "Game Developer"
  ];
  @override
  void initState() {
    _controller.nama.text = '';
    _controller.email.text = '';
    _controller.password.text = '';
    _controller.alamat.text = '';
    _controller.no_hp.text = '';
    _controller.divisi = '';
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
            "Tambah Data",
            style: textWhite3,
          )),
      body: Container(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              TextFormField(
                controller: _controller.nama,
                decoration: InputDecoration(
                  labelText: "Nama *",
                ),
                validator: (value) {
                  return value.trim().isEmpty ? 'Mohon masukan Nama' : null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _controller.email,
                decoration: InputDecoration(
                  labelText: "Email *",
                ),
                validator: (value) {
                  return value.trim().isEmpty
                      ? 'Mohon masukan Email'
                      : EmailValidator.validate(value)
                          ? null
                          : "Mohon masukan email dengan benar";
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _controller.alamat,
                decoration: InputDecoration(
                  labelText: "Alamat *",
                ),
                validator: (value) {
                  return value.trim().isEmpty ? 'Mohon masukan Alamat' : null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _controller.no_hp,
                decoration: InputDecoration(
                  labelText: "No HP *",
                ),
                validator: (value) {
                  return value.trim().isEmpty ? 'Mohon masukan No HP' : null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              DropdownButtonFormField(
                style: textGrey3,
                decoration: InputDecoration(
                  labelText: 'Divisi',
                ),
                value: divisival,
                items: divisi.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _controller.divisi = value;
                    divisival = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Mohon pilih Divisi";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                obscureText: true,
                controller: _controller.password,
                decoration: InputDecoration(
                  labelText: "Password *",
                ),
                validator: (value) {
                  return value.trim().isEmpty
                      ? 'Mohon masukan Password'
                      : value.trim().length < 8
                          ? 'Minimum 8 karakter'
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
                          _controller.createUser();
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

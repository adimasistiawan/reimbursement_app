import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/controllers/homecontroller.dart';
import 'package:siepegawai/controllers/pegawaicontroller.dart';
import 'package:siepegawai/theme.dart';

class UbahProfilePegawai extends StatefulWidget {
  @override
  _UbahProfilePegawaiState createState() => _UbahProfilePegawaiState();
}

class _UbahProfilePegawaiState extends State<UbahProfilePegawai> {
  HomeController _controller = Get.put(HomeController());
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool changepass = false;
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
          backgroundColor: navy,
          title: Text(
            "Ubah Profil",
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
                          : "Mohon masukan format email yang benar";
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
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.password.text = "";
                    if (!changepass) {
                      changepass = true;
                    } else {
                      changepass = false;
                    }
                  });
                },
                child: Text(
                  changepass ? "Batal Ubah Password" : "Ubah Password",
                  style: changepass ? textRed3 : textYellow3,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: changepass,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
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
                          _controller.updateUserPegawai(
                              _controller.data_pegawai.value.data.user.id);
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/controllers/logincontroller.dart';
import 'package:siepegawai/theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var form = GlobalKey<FormState>();
  LoginController _login = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(28, 100, 28, 0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 100,
                  child: Image.asset('assets/mitrait.png'),
                ),
                Text(
                  "Masuk Untuk Mendapatkan Akses",
                  style: textGrey2,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Form(
                      key: form,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _login.email,
                            decoration: InputDecoration(labelText: "Email"),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return "Mohon masukan Email";
                              }
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _login.password,
                            decoration: InputDecoration(
                              labelText: "Password",
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return "Mohon masukan Password";
                              }
                            },
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
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
                                    'Masuk',
                                    style: textWhite2,
                                  ),
                                  onPressed: () {
                                    if (form.currentState.validate()) {
                                      _login.login();
                                    }
                                  }),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

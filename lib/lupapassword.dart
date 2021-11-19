import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/controllers/logincontroller.dart';
import 'package:siepegawai/theme.dart';

class LupaPassword extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LupaPassword> {
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
                Text(
                  "Masukan Email Untuk Mereset Password",
                  style: textGrey2,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Form(
                      key: form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _login.email2,
                            decoration: InputDecoration(labelText: "Email"),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return "Mohon masukan Email";
                              }
                            },
                          ),
                          SizedBox(
                            height: 24,
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
                                    'Reset Password',
                                    style: textWhite2,
                                  ),
                                  onPressed: () {
                                    if (form.currentState.validate()) {
                                      _login.lupa_password();
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

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
        padding: EdgeInsets.fromLTRB(22, 100, 22, 0),
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
                  "Selamat Datang",
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _login.email,
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: textBlack2,
                                  icon: Icon(
                                    Icons.mail,
                                    color: black,
                                  ),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return "Email required";
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _login.password,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: textBlack2,
                                  icon: Icon(
                                    Icons.lock,
                                    color: black,
                                  ),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return "Password required";
                                }
                              },
                              obscureText: true,
                            ),
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

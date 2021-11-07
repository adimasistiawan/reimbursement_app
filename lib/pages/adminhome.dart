import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siepegawai/controllers/homecontroller.dart';
import 'package:siepegawai/login.dart';
import 'package:siepegawai/model/pengumuman.dart';
import 'package:siepegawai/pages/admin/cuti/index.dart';
import 'package:siepegawai/pages/admin/pegawai/pegawai.dart';
import 'package:siepegawai/pages/admin/pengumuman/pengumuman.dart';
import 'package:siepegawai/pages/admin/profile.dart';
import 'package:siepegawai/pages/admin/reimbursement/index.dart';
import 'package:siepegawai/theme.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    _homeController.getDataAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: navy, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      body: Obx(
        () => _homeController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => _homeController.getDataAdmin(),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Container(
                          color: Color(0xff130f40),
                          height: size.height * .50,
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: 200,
                                height: 100,
                                child: Image.asset('assets/mitrait.png'),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(left: 18),
                                      child: Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.clip,
                                          text: TextSpan(
                                              style: textWhite4,
                                              text: "Hallo " +
                                                  _homeController.data_admin
                                                      .value.data.user.nama),
                                        ),
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.to(UbahProfileAdmin()),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      margin:
                                          EdgeInsets.only(top: 10, left: 18),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[700],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Text(
                                            "Ubah Profil",
                                            style: textWhite,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showAlertDialog(context);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(8),
                                        margin:
                                            EdgeInsets.only(left: 10, top: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.red[600],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.logout,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                              "Keluar",
                                              style: textWhite,
                                            )
                                          ],
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 240),
                          padding: EdgeInsets.only(right: 15.0, left: 15),
                          height: MediaQuery.of(context).size.height - 50.0,
                          child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.86,
                            primary: false,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    left: 5.0,
                                    right: 5.0),
                                child: InkWell(
                                  onTap: () => Get.to(ReimbursementPage()),
                                  child: Container(
                                    padding: EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3.0,
                                              blurRadius: 5.0)
                                        ],
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 100,
                                            child: Image.asset(
                                                'assets/business-report.png')),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Reimbursement",
                                          style: textBlack2Bold,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Visibility(
                                          visible: _homeController.data_admin
                                                  .value.data.reimbursement >
                                              0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      2), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              _homeController.data_admin.value
                                                  .data.reimbursement
                                                  .toString(),
                                              style: textWhite2,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    left: 5.0,
                                    right: 5.0),
                                child: InkWell(
                                  onTap: () => Get.to(CutiPage()),
                                  child: Container(
                                    padding: EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3.0,
                                              blurRadius: 5.0)
                                        ],
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 100,
                                            child: Image.asset(
                                                'assets/documents.png')),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Cuti",
                                          style: textBlack2Bold,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Visibility(
                                          visible: _homeController
                                                  .data_admin.value.data.cuti >
                                              0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      2), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              _homeController
                                                  .data_admin.value.data.cuti
                                                  .toString(),
                                              style: textWhite2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    left: 5.0,
                                    right: 5.0),
                                child: InkWell(
                                  onTap: () => Get.to(PegawaiPage()),
                                  child: Container(
                                    padding: EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3.0,
                                              blurRadius: 5.0)
                                        ],
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 100,
                                            child:
                                                Image.asset('assets/user.png')),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Karyawan",
                                          style: textBlack2Bold,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    left: 5.0,
                                    right: 5.0),
                                child: InkWell(
                                  onTap: () => Get.to(PengumumanPage()),
                                  child: Container(
                                    padding: EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3.0,
                                              blurRadius: 5.0)
                                        ],
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: 100,
                                            child: Image.asset(
                                                'assets/megaphone.png')),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Pengumuman",
                                          style: textBlack2Bold,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Tidak"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ya"),
      onPressed: () {
        logout();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Apakah kamu yakin ingin keluar?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Get.offAll(LoginPage());
  }
}

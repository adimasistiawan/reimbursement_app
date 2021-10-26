import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/homecontroller.dart';
import 'package:siepegawai/login.dart';
import 'package:siepegawai/model/pengumuman.dart';
import 'package:siepegawai/pages/admin/pegawai/pegawai.dart';
import 'package:siepegawai/pages/admin/pengumuman/pengumuman.dart';
import 'package:siepegawai/pages/admin/reimbursement/index.dart';
import 'package:siepegawai/pages/karyawan/cuti/index.dart';
import 'package:siepegawai/pages/karyawan/pengumuman/detail.dart';
import 'package:siepegawai/pages/karyawan/pengumuman/index.dart';
import 'package:siepegawai/pages/karyawan/profile.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/index.dart';
import 'package:siepegawai/theme.dart';

class PegawaiHome extends StatefulWidget {
  @override
  _PegawaiHomeState createState() => _PegawaiHomeState();
}

class _PegawaiHomeState extends State<PegawaiHome> {
  HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    _homeController.getDataPegawai();
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
                onRefresh: () => _homeController.getDataPegawai(),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      padding:
                                          EdgeInsets.only(left: 18, right: 18),
                                      child: Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.clip,
                                          text: TextSpan(
                                              style: textWhite4,
                                              text: "Hallo " +
                                                  _homeController.data_pegawai
                                                      .value.data.user.nama),
                                        ),
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.to(UbahProfilePegawai()),
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
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15.0, left: 15),
                                child: Container(
                                    margin: EdgeInsets.only(top: 40),
                                    padding: EdgeInsets.all(18),
                                    width: double.infinity,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rp. " +
                                              number_format
                                                  .format(_homeController
                                                              .data_pegawai
                                                              .value
                                                              .data
                                                              .total
                                                              .total ==
                                                          null
                                                      ? 0
                                                      : _homeController
                                                          .data_pegawai
                                                          .value
                                                          .data
                                                          .total
                                                          .total)
                                                  .toString(),
                                          style: textBlue4Bold,
                                        ),
                                        Text(
                                          "Total Reimbursement Bulan Ini",
                                          style: textBlack,
                                        )
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 320),
                          padding: EdgeInsets.only(right: 15.0, left: 15),
                          height: MediaQuery.of(context).size.height - 50.0,
                          child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                            primary: false,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    left: 5.0,
                                    right: 5.0),
                                child: InkWell(
                                  onTap: () =>
                                      Get.to(ReimbursementPegawaiPage()),
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
                                          visible: _homeController.data_pegawai
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
                                              _homeController.data_pegawai.value
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
                                  onTap: () => Get.to(CutiPegawaiPage()),
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
                                          visible: _homeController.data_pegawai
                                                  .value.data.cuti >
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
                                                  .data_pegawai.value.data.cuti
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
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          margin: EdgeInsets.only(top: 580),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Pengumuman",
                                    style: textBlack3,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        Get.to(PengumumanPegawaiPage()),
                                    child: Text(
                                      "Lihat Semua",
                                      style: textBlack3Bold,
                                    ),
                                  ),
                                ],
                              ),
                              _homeController.data_pegawai.value.data.pengumuman
                                          .length ==
                                      0
                                  ? Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              "Tidak Ada",
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(top: 20),
                                      height: 175,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _homeController
                                              .data_pegawai
                                              .value
                                              .data
                                              .pengumuman
                                              .length,
                                          itemBuilder: (context, index) {
                                            print(_homeController.data_pegawai
                                                .value.data.pengumuman.length);
                                            return GestureDetector(
                                              onTap: () => Get.to(
                                                  PengumumanPegawaiDetail(
                                                id: _homeController
                                                    .data_pegawai
                                                    .value
                                                    .data
                                                    .pengumuman[index]
                                                    .id,
                                              )),
                                              child: Container(
                                                width: 280,
                                                height: 180,
                                                padding: EdgeInsets.all(18),
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                          spreadRadius: 2.0,
                                                          blurRadius: 5.0)
                                                    ],
                                                    color: Colors.blue[500]),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Text(
                                                    //   _homeController.data_pegawai.value
                                                    //       .data.pengumuman[index].judul,
                                                    //   style: textBlack3Bold,
                                                    // ),
                                                    Flexible(
                                                      child: RichText(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        text: TextSpan(
                                                            style:
                                                                textWhite3Bold,
                                                            text: _homeController
                                                                .data_pegawai
                                                                .value
                                                                .data
                                                                .pengumuman[
                                                                    index]
                                                                .judul),
                                                      ),
                                                    ),
                                                    Text(
                                                      formatter.format(DateTime
                                                          .parse(_homeController
                                                              .data_pegawai
                                                              .value
                                                              .data
                                                              .pengumuman[index]
                                                              .tanggal)),
                                                      style: textWhite2,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Flexible(
                                                      child: RichText(
                                                        overflow:
                                                            TextOverflow.clip,
                                                        text: TextSpan(
                                                            style: textWhite2,
                                                            text: _homeController
                                                                .data_pegawai
                                                                .value
                                                                .data
                                                                .pengumuman[
                                                                    index]
                                                                .isi),
                                                      ),
                                                    ),

                                                    GestureDetector(
                                                      onTap: () => Get.to(
                                                          PengumumanPegawaiDetail(
                                                        id: _homeController
                                                            .data_pegawai
                                                            .value
                                                            .data
                                                            .pengumuman[index]
                                                            .id,
                                                      )),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        child: Flexible(
                                                          child: RichText(
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            text: TextSpan(
                                                                style:
                                                                    textWhite2Bold,
                                                                text:
                                                                    "Lihat Selengkapnya"),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
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

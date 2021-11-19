import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/circle.dart';
import 'package:siepegawai/controllers/pegawaicontroller.dart';
import 'package:siepegawai/model/user.dart';
import 'package:siepegawai/pages/admin/pegawai/pegawaidetail.dart';
import 'package:siepegawai/pages/admin/pegawai/tambahpegawai.dart';
import 'package:siepegawai/theme.dart';

class PegawaiPage extends StatefulWidget {
  @override
  _PegawaiPageState createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  PegawaiController _pegawaiController = Get.put(PegawaiController());

  List<AllUser> _searchResult = [];

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _pegawaiController.alluser.forEach((a) {
      print(text);
      if (a.nama.toLowerCase().contains(text.toLowerCase())) {
        setState(() {
          _searchResult.add(a);
        });
      }
    });

    setState(() {});
  }

  @override
  void initState() {
    _pegawaiController.getDataAllUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: grey,
      appBar: AppBar(
          backgroundColor: navy,
          title: Text(
            "Karyawan",
            style: textWhite3,
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(TambahPegawai());
        },
        label: Text(
          'Tambah',
          style: textWhite2,
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: navy,
      ),
      body: Container(
        height: size.height,
        padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Obx(() => _pegawaiController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Cari ..",
                        hintStyle: textGrey2,
                      ),
                      onChanged: onSearchTextChanged,
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 60),
                        child: _searchResult.length == 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount:
                                    _pegawaiController.alluser.value.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: double.infinity,
                                    height: 65,
                                    padding: EdgeInsets.only(
                                        top: 10, left: 18, right: 18),
                                    margin: EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  style: textBlack3Bold,
                                                  text: _pegawaiController
                                                      .alluser
                                                      .value[index]
                                                      .nama,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.clip,
                                                text: TextSpan(
                                                    style: textBlack,
                                                    text: _pegawaiController
                                                        .alluser
                                                        .value[index]
                                                        .divisi),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () => Get.to(PegawaiDetail(
                                            id: _pegawaiController
                                                .alluser.value[index].id,
                                          )),
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Lihat",
                                                    style: textBlack,
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    size: 24,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _searchResult.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: double.infinity,
                                      height: 65,
                                      padding: EdgeInsets.only(
                                          top: 10, left: 18, right: 18),
                                      margin: EdgeInsets.only(top: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text: TextSpan(
                                                    style: textBlack3Bold,
                                                    text: _searchResult[index]
                                                        .nama,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Flexible(
                                                child: RichText(
                                                  overflow: TextOverflow.clip,
                                                  text: TextSpan(
                                                      style: textBlack,
                                                      text: _searchResult[index]
                                                          .divisi),
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () => Get.to(PegawaiDetail(
                                              id: _searchResult[index].id,
                                            )),
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 3),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Lihat",
                                                      style: textBlack,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                      size: 24,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )),
                  )
                ],
              )),
      ),
    );
  }
}

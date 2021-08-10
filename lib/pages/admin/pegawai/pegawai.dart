import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      if (a.nama.contains(text)) _searchResult.add(a);
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
        padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Obx(() => _pegawaiController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    height: 50,
                    width: double.infinity * 0.60,
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: "Cari..",
                          hintStyle: textGrey2,
                          border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                  ),
                  _searchResult.length == 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: _pegawaiController.alluser.value.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Get.to(PegawaiDetail(
                                id: _pegawaiController.alluser.value[index].id,
                              )),
                              child: Container(
                                width: double.infinity,
                                height: 95,
                                padding: EdgeInsets.only(
                                    top: 10, left: 18, right: 10),
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          style: textBlack3,
                                          text: _pegawaiController
                                              .alluser.value[index].nama,
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
                                            style: textBlack2,
                                            text: "Email : " +
                                                _pegawaiController.alluser
                                                    .value[index].email),
                                      ),
                                    ),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.clip,
                                        text: TextSpan(
                                            style: textBlack2,
                                            text: "Divisi : " +
                                                _pegawaiController.alluser
                                                    .value[index].divisi),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _searchResult.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Get.to(PegawaiDetail(
                                id: _searchResult[index].id,
                              )),
                              child: Container(
                                width: double.infinity,
                                height: 95,
                                padding: EdgeInsets.only(
                                    top: 10, left: 18, right: 10),
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          style: textBlack3,
                                          text: _searchResult[index].nama,
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
                                            style: textBlack2,
                                            text: "Email : " +
                                                _searchResult[index].email),
                                      ),
                                    ),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.clip,
                                        text: TextSpan(
                                            style: textBlack2,
                                            text: "Divisi : " +
                                                _searchResult[index].divisi),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                ],
              )),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/controllers/pegawaicontroller.dart';
import 'package:siepegawai/pages/admin/pegawai/ubahpegawai.dart';
import 'package:siepegawai/theme.dart';

class PegawaiDetail extends StatefulWidget {
  @override
  int id;
  PegawaiDetail({this.id});
  _PegawaiDetailState createState() => _PegawaiDetailState();
}

class _PegawaiDetailState extends State<PegawaiDetail> {
  PegawaiController _pegawaiController = Get.put(PegawaiController());

  @override
  void initState() {
    _pegawaiController.getDataUser(widget.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
          backgroundColor: navy,
          title: Text(
            "Detail Karyawan",
            style: textWhite3,
          )),
      body: Container(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Obx(() => _pegawaiController.isLoading2.value
            ? Center(child: CircularProgressIndicator())
            : Container(
                width: double.infinity,
                height: 200,
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
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
                          style: textBlack2,
                          text: "Nama : " + _pegawaiController.user.value.nama,
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
                            text: "Divisi : " +
                                _pegawaiController.user.value.divisi),
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
                                _pegawaiController.user.value.email),
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
                            text: "No HP : " +
                                _pegawaiController.user.value.noHp),
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
                            text: "Alamat : " +
                                _pegawaiController.user.value.alamat),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          child: MaterialButton(
                              color: Colors.red,
                              splashColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Hapus',
                                style: textWhite2,
                              ),
                              onPressed: () {
                                showAlertDialog(context);
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: MaterialButton(
                              color: Colors.orange,
                              splashColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Ubah',
                                style: textWhite2,
                              ),
                              onPressed: () {
                                Get.to(UbahPegawai());
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              )),
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
        _pegawaiController.deleteUser(_pegawaiController.user.value.id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Apakah kamu yakin ingin menghapus data ini?"),
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siepegawai/controllers/pegawaicontroller.dart';
import 'package:siepegawai/controllers/pengumumancontroller.dart';
import 'package:siepegawai/pages/admin/pegawai/ubahpegawai.dart';
import 'package:siepegawai/pages/admin/pengumuman/ubah.dart';
import 'package:siepegawai/theme.dart';

class PengumumanDetail extends StatefulWidget {
  @override
  int id;
  PengumumanDetail({this.id});
  _PengumumanDetailState createState() => _PengumumanDetailState();
}

class _PengumumanDetailState extends State<PengumumanDetail> {
  PengumumanController _pengumumanController = Get.put(PengumumanController());
  DateFormat formatter = DateFormat("dd-MM-yyyy");
  @override
  void initState() {
    _pengumumanController.getDetail(widget.id);
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
              "Detail Pengumuman",
              style: textWhite3,
            )),
        body: Obx(() => _pengumumanController.isLoading2.value
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
                      width: double.infinity,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 300,
                                child: Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: textBlack3Bold,
                                      text: _pengumumanController
                                          .detail.value.judul,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.schedule,
                                    size: 16,
                                  )),
                              Flexible(
                                child: RichText(
                                  overflow: TextOverflow.clip,
                                  text: TextSpan(
                                      style: textBlack,
                                      text: formatter.format(DateTime.parse(
                                          _pengumumanController
                                              .detail.value.tanggal))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _pengumumanController.detail.value.isi,
                            style: textBlack2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: MaterialButton(
                              color: Colors.green[400],
                              splashColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Ubah',
                                style: textWhite2,
                              ),
                              onPressed: () {
                                Get.to(UbahPengumuman());
                              }),
                        ),
                        Container(
                          width: double.infinity,
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
                      ],
                    ),
                  ],
                ),
              )));
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
        _pengumumanController
            .deletePengumuman(_pengumumanController.detail.value.id);
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

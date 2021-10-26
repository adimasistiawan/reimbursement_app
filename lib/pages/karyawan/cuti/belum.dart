import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/circle.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/cuticontroller.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/pages/admin/reimbursement/detail.dart';
import 'package:siepegawai/pages/karyawan/cuti/detail.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/detail.dart';
import 'package:siepegawai/theme.dart';

class CutiBelumPegawai extends StatelessWidget {
  const CutiBelumPegawai({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CutiController _cutiController = Get.put(CutiController());
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Obx(() => _cutiController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _cutiController.getDataUser(),
              child: _cutiController.belum.length == 0
                  ? Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Tidak Ada",
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _cutiController.belum.value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: 150,
                          padding: EdgeInsets.only(
                              top: 18, left: 18, right: 24, bottom: 18),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _cutiController.belum.value[index].kode,
                                    style: textBlack3Bold,
                                  ),
                                  GestureDetector(
                                    onTap: () => Get.to(CutiDetailPegawaiPage(
                                      id: _cutiController.belum.value[index].id,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Lihat",
                                              style: textBlack,
                                            ),
                                            Icon(
                                              Icons.remove_red_eye_outlined,
                                              size: 24,
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                              Row(
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
                                              _cutiController.belum.value[index]
                                                  .tanggalPengajuan))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Flexible(
                                child: RichText(
                                  overflow: TextOverflow.clip,
                                  text: TextSpan(
                                      style: textBlack2,
                                      text: "Cuti Dari " +
                                          formatterdate.format(DateTime.parse(
                                              _cutiController
                                                  .belum.value[index].dari)) +
                                          " Sampai " +
                                          formatterdate.format(DateTime.parse(
                                              _cutiController
                                                  .belum.value[index].sampai))),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Text(
                                  _cutiController.belum.value[index].status,
                                  style: _cutiController
                                              .belum.value[index].status ==
                                          "Belum Dikonfirmasi"
                                      ? textYellow2Bold
                                      : _cutiController
                                                  .belum.value[index].status ==
                                              "Telah Diterima"
                                          ? textGreen2Bold
                                          : textRed2Bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Visibility(
                                    visible: _cutiController
                                            .belum.value[index].status !=
                                        "Belum Dikonfirmasi",
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text("Dikonfirmasi pada :")),
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              _cutiController.belum.value[index]
                                                          .tanggalKonfirmasi ==
                                                      null
                                                  ? "-"
                                                  : formatter.format(DateTime
                                                      .parse(_cutiController
                                                          .belum
                                                          .value[index]
                                                          .tanggalKonfirmasi)),
                                              style: textBlack2,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
            )),
    );
  }
}

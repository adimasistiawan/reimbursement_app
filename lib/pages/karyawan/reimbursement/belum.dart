import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/circle.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/pages/admin/reimbursement/detail.dart';
import 'package:siepegawai/pages/karyawan/reimbursement/detail.dart';
import 'package:siepegawai/theme.dart';

class ReimbursementBelumPegawai extends StatelessWidget {
  const ReimbursementBelumPegawai({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReimbursementController _reimbursementController =
        Get.put(ReimbursementController());
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Obx(() => _reimbursementController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _reimbursementController.getDataUser(),
              child: _reimbursementController.belum.length == 0
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      itemCount: _reimbursementController.belum.value.length,
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
                                    _reimbursementController
                                        .belum.value[index].kode,
                                    style: textBlack3Bold,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        Get.to(ReimbursementDetailPegawaiPage(
                                      id: _reimbursementController
                                          .belum.value[index].id,
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
                                              _reimbursementController
                                                  .belum
                                                  .value[index]
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
                                      text: "Nominal : Rp. " +
                                          number_format
                                              .format(_reimbursementController
                                                  .belum.value[index].nominal)
                                              .toString()),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Text(
                                  _reimbursementController
                                      .belum.value[index].status,
                                  style: _reimbursementController
                                              .belum.value[index].status ==
                                          "Belum Dikonfirmasi"
                                      ? textYellow2Bold
                                      : _reimbursementController
                                                  .belum.value[index].status ==
                                              "Telah Diterima"
                                          ? textGreen2Bold
                                          : textRed2Bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Visibility(
                                    visible: _reimbursementController
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
                                              _reimbursementController
                                                          .belum
                                                          .value[index]
                                                          .tanggalKonfirmasi ==
                                                      null
                                                  ? "-"
                                                  : formatter.format(DateTime.parse(
                                                      _reimbursementController
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siepegawai/const.dart';
import 'package:siepegawai/controllers/reimbursementcontroller.dart';
import 'package:siepegawai/pages/admin/reimbursement/detail.dart';
import 'package:siepegawai/theme.dart';

class ReimbursementTelahAdmin extends StatelessWidget {
  const ReimbursementTelahAdmin({Key key}) : super(key: key);

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
              onRefresh: () => _reimbursementController.getDataAll(),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _reimbursementController.telah.value.length,
                itemBuilder: (context, index) {
                  print(_reimbursementController.telah.length);
                  return GestureDetector(
                    onTap: () => Get.to(ReimbursementDetailPage(
                      id: _reimbursementController.telah.value[index].id,
                    )),
                    child: _reimbursementController.telah.length == 0
                        ? Container(
                            child: Center(
                              child: Text(
                                "Kosong",
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: 200,
                            padding: EdgeInsets.only(
                                top: 18, left: 18, right: 10, bottom: 18),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 5,
                                            left: 10,
                                            right: 10,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          _reimbursementController
                                              .telah.value[index].kode,
                                          style: textBlack2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 5,
                                            left: 10,
                                            right: 10,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          color: _reimbursementController.telah
                                                      .value[index].status ==
                                                  "Belum Dikonfirmasi"
                                              ? Colors.yellow[700]
                                              : _reimbursementController
                                                          .telah
                                                          .value[index]
                                                          .status ==
                                                      "Telah Diterima"
                                                  ? Colors.green[300]
                                                  : Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          _reimbursementController
                                              .telah.value[index].status,
                                          style: textWhite2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(Icons.person)),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          style: textBlack3,
                                          text: _reimbursementController
                                              .telah.value[index].nama,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child:
                                            Icon(Icons.calendar_today_rounded)),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.clip,
                                        text: TextSpan(
                                            style: textBlack2,
                                            text: formatter.format(
                                                DateTime.parse(
                                                    _reimbursementController
                                                        .telah
                                                        .value[index]
                                                        .tanggalPengajuan))),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.clip,
                                    text: TextSpan(
                                        style: textBlack2,
                                        text: "Nominal : Rp. " +
                                            number_format
                                                .format(_reimbursementController
                                                    .telah.value[index].nominal)
                                                .toString()),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: _reimbursementController
                                              .telah.value[index].status !=
                                          "Belum Dikonfirmasi",
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Dikonfirmasi pada : ",
                                            style: textBlack2,
                                          )),
                                          Container(
                                              child: Text(
                                            _reimbursementController
                                                        .telah
                                                        .value[index]
                                                        .tanggalKonfirmasi ==
                                                    null
                                                ? "-"
                                                : formatter.format(
                                                    DateTime.parse(
                                                        _reimbursementController
                                                            .telah
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
                          ),
                  );
                },
              ),
            )),
    );
  }
}

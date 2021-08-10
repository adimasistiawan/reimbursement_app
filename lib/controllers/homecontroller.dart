import 'package:get/get.dart';
import 'package:siepegawai/api/service.dart';
import 'package:siepegawai/model/homeadmin.dart';
import 'package:siepegawai/model/homepegawai.dart';
import 'package:siepegawai/model/profile.dart';

class HomeController extends GetxController {
  var data_admin = HomeAdminClass().obs;
  var data_pegawai = HomePegawaiClass().obs;
  var isLoading = true.obs;
  @override
  void onInit() async {
    super.onInit();
  }

  getDataAdmin() async {
    isLoading.value = true;
    await Services().homeAdmin().then((val) {
      data_admin.value = val;
    });
    isLoading.value = false;
    update();
  }

  getDataPegawai() async {
    isLoading.value = true;
    await Services().homePegawai().then((val) {
      print(val.data.pengumuman.length);
      data_pegawai.value = val;
    });
    isLoading.value = false;
    update();
  }
}

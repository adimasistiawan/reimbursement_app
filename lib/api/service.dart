import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siepegawai/api/response.dart';
import 'package:siepegawai/controllers/logincontroller.dart';
import 'package:http/http.dart' as http;
import 'package:siepegawai/model/cuti.dart';
import 'package:siepegawai/model/homeadmin.dart' as admin;
import 'package:siepegawai/model/homepegawai.dart' as pegawai;
import 'package:siepegawai/model/message.dart';
import 'package:siepegawai/model/pengumuman.dart';
import 'package:siepegawai/model/pengumumandetail.dart';
import 'package:siepegawai/model/profile.dart';
import 'package:siepegawai/model/reimbursement.dart';
import 'package:siepegawai/model/user.dart';

shared() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token');
  return token;
}

class Services {
  String baseUrl = "http://10.0.2.2:5000/api";

  Future<LoginClass> login(String email, String password) async {
    final response = await http.post("$baseUrl/users/login",
        body: {'email': email, 'password': password},
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      print(response.statusCode == 200);
      return Responses().loginFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<Message> lupa_password(String email) async {
    final response = await http.post("$baseUrl/users/lupa-password",
        body: {'email': email}, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      print(response.statusCode == 200);
      return Responses().messageFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<ProfileClass> getProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/users/profile",
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().profileFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<admin.HomeAdminClass> homeAdmin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/users/home",
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().homeAdminFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<pegawai.HomePegawaiClass> homePegawai() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/users/home-pegawai",
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().homePegawaiFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<AllUserClass> getAllUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/users/",
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().allUserFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<UserClass> getUser(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/users/" + id.toString(),
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().userFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<Message> createUser(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.post("$baseUrl/users/create", body: {
      'nama': user.nama,
      'email': user.email,
      'password': user.password,
      'alamat': user.alamat,
      'no_hp': user.noHp,
      'divisi': user.divisi,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': token
    });

    if (response.statusCode == 200) {
      Get.back();
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<Message> deleteUser(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/users/delete/" + id.toString(),
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<Message> updateUser(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response =
        await http.post("$baseUrl/users/update/" + user.id.toString(), body: {
      'nama': user.nama,
      'email': user.email,
      'password': user.password,
      'alamat': user.alamat,
      'no_hp': user.noHp,
      'divisi': user.divisi,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': token
    });

    if (response.statusCode == 200) {
      Get.back();
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<Message> updateProfileAdmin(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http
        .post("$baseUrl/users/profile/update/" + user.id.toString(), body: {
      'nama': user.nama,
      'email': user.email,
      'password': user.password,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': token
    });

    if (response.statusCode == 200) {
      Get.back();
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<Message> updateProfilePegawai(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.post(
        "$baseUrl/users/profile/update-pegawai/" + user.id.toString(),
        body: {
          'nama': user.nama,
          'email': user.email,
          'password': user.password,
          'alamat': user.alamat,
          'no_hp': user.noHp,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': token
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      Get.back();
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<PengumumanClass> getPengumuman() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/pengumuman/",
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().pengumumanFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<Message> createPengumuman(Pengumuman pengemuman) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.post("$baseUrl/pengumuman/create", body: {
      'judul': pengemuman.judul,
      'isi': pengemuman.isi,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': token
    });

    if (response.statusCode == 200) {
      Get.back();
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<Message> updatePengumuman(Pengumuman pengumuman) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http
        .post("$baseUrl/pengumuman/update/" + pengumuman.id.toString(), body: {
      'judul': pengumuman.judul,
      'isi': pengumuman.isi,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': token
    });

    if (response.statusCode == 200) {
      Get.back();
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<Message> deletePengumuman(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get(
        "$baseUrl/pengumuman/delete/" + id.toString(),
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<PengumumanDetailClass> detailPengumuman(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/pengumuman/" + id.toString(),
        headers: {'Accept': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      return Responses().pengumumanDetailFromJson(response.body);
    } else {
      Get.back();
      return throw Exception('${response.body}');
    }
  }

  Future<ReimbursementClass> getReimbursement() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/reimbursement/null/null/null",
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().reimbursementFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<ReimbursementClass> getReimbursementFilter(
      String dari, String sampai, String kode) async {
    dari = dari == '' ? "null" : dari;
    sampai = sampai == '' ? "null" : sampai;
    kode = kode == '' ? "null" : kode;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get(
        "$baseUrl/reimbursement/" + dari + "/" + sampai + "/" + kode,
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().reimbursementFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<ReimbursementClass> getReimbursementUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/reimbursement/me/null/null/null",
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().reimbursementFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<ReimbursementClass> getReimbursementUserFilter(
      String dari, String sampai, String kode) async {
    dari = dari == '' ? "null" : dari;
    sampai = sampai == '' ? "null" : sampai;
    kode = kode == '' ? "null" : kode;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get(
        "$baseUrl/reimbursement/me/" + dari + "/" + sampai + "/" + kode,
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().reimbursementFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<Message> buatReimbursement(
      File attachment, String nominal, String keterangan) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');

    Map<String, String> heads = {
      'Authorization': '$token',
      "Content-type": "multipart/form-data",
      "accept": "application/json"
    };

    var url = Uri.parse("$baseUrl/reimbursement/create");
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(heads);
    print(attachment);
    if (attachment != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'bukti_pembayaran', attachment.path));
    } else {
      request.fields['bukti_pembayaran'] = '';
    }
    request.fields['keterangan'] = keterangan;
    request.fields['nominal'] = nominal.toString();
    var responses = await request.send();
    var response = await http.Response.fromStream(responses);

    if (response.statusCode == 200) {
      return Message.fromJson(json.decode(response.body));
    } else {
      print('$baseUrl');

      throw Exception('${response.body}');
    }
  }

  Future<ReimbursementDetailClass> detailReimbursement(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/reimbursement/" + id.toString(),
        headers: {'Accept': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      return Responses().reimbursementDetailFromJson(response.body);
    } else {
      Get.back();
      return throw Exception('${response.body}');
    }
  }

  Future<Message> deleteReimbursement(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get(
        "$baseUrl/reimbursement/delete/" + id.toString(),
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<Message> updateReimbursement(ReimbursementDetail reimbursement) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.post(
        "$baseUrl/reimbursement/updatestatus/" + reimbursement.id.toString(),
        body: json.encode({
          'status': reimbursement.status,
          'alasan_ditolak': reimbursement.alasanDitolak,
        }),
        headers: {
          'Accept': 'application/json',
          'Authorization': token,
          "Content-Type": "application/json",
        });

    if (response.statusCode == 200) {
      Get.back();
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<ReimbursementClass> historyReimbursement(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get(
        "$baseUrl/reimbursement/history/" + id.toString() + "/null/null/null",
        headers: {'Accept': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      return Responses().reimbursementFromJson(response.body);
    } else {
      Get.back();
      return throw Exception('${response.body}');
    }
  }

  Future<ReimbursementClass> historyReimbursementFilter(
      int id, String dari, String sampai, String kode) async {
    dari = dari == '' ? "null" : dari;
    sampai = sampai == '' ? "null" : sampai;
    kode = kode == '' ? "null" : kode;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get(
        "$baseUrl/reimbursement/history/" +
            id.toString() +
            "/" +
            dari +
            "/" +
            sampai +
            "/" +
            kode,
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().reimbursementFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<Message> updateAllReimbursement(
      File attachment, String nominal, String keterangan, int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');

    Map<String, String> heads = {
      'Authorization': '$token',
      "Content-type": "multipart/form-data",
      "accept": "application/json"
    };

    var url = Uri.parse("$baseUrl/reimbursement/update/" + id.toString());
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(heads);
    if (attachment != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'bukti_pembayaran', attachment.path));
    } else {
      request.fields['bukti_pembayaran'] = '';
    }
    request.fields['keterangan'] = keterangan;
    request.fields['nominal'] = nominal.toString();
    var responses = await request.send();
    var response = await http.Response.fromStream(responses);

    print(response.statusCode);
    if (response.statusCode == 200) {
      return Message.fromJson(json.decode(response.body));
    } else {
      print('$baseUrl');

      throw Exception('${response.body}');
    }
  }

  Future<CutiClass> getCutiUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/cuti/me/null/null/null",
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().cutiFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<CutiClass> getCutiUserFilter(
      String dari, String sampai, String kode) async {
    dari = dari == '' ? "null" : dari;
    sampai = sampai == '' ? "null" : sampai;
    kode = kode == '' ? "null" : kode;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get(
        "$baseUrl/cuti/me/" + dari + "/" + sampai + "/" + kode,
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().cutiFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<CutiClass> getCuti() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/cuti/null/null/null",
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().cutiFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<CutiClass> getCutiFilter(
      String dari, String sampai, String kode) async {
    dari = dari == '' ? "null" : dari;
    sampai = sampai == '' ? "null" : sampai;
    kode = kode == '' ? "null" : kode;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get(
        "$baseUrl/cuti/" + dari + "/" + sampai + "/" + kode,
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().cutiFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<CutiDetailClass> detailCuti(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/cuti/" + id.toString(),
        headers: {'Accept': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      return Responses().cutiDetailFromJson(response.body);
    } else {
      Get.back();
      return throw Exception('${response.body}');
    }
  }

  Future<CutiClass> historyCuti(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get(
        "$baseUrl/cuti/history/" + id.toString() + "/null/null/null",
        headers: {'Accept': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      return Responses().cutiFromJson(response.body);
    } else {
      Get.back();
      return throw Exception('${response.body}');
    }
  }

  Future<CutiClass> historyCutiFilter(
      int id, String dari, String sampai, String kode) async {
    dari = dari == '' ? "null" : dari;
    sampai = sampai == '' ? "null" : sampai;
    kode = kode == '' ? "null" : kode;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get(
        "$baseUrl/cuti/history/" +
            id.toString() +
            "/" +
            dari +
            "/" +
            sampai +
            "/" +
            kode,
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return Responses().cutiFromJson(response.body);
    } else {
      return throw Exception('${response.body}');
    }
  }

  Future<Message> createCuti(Cuti cuti) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.post("$baseUrl/cuti/create",
        body: {'dari': cuti.dari, 'sampai': cuti.sampai, 'alasan': cuti.alasan},
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      Get.back();
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<Message> updateCuti(CutiDetail cuti) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    print(cuti.alasanDitolak);
    final response =
        await http.post("$baseUrl/cuti/updatestatus/" + cuti.id.toString(),
            body: json.encode({
              'status': cuti.status,
              'alasan_ditolak': cuti.alasanDitolak,
            }),
            headers: {
          'Accept': 'application/json',
          'Authorization': token,
          "Content-Type": "application/json",
        });

    if (response.statusCode == 200) {
      Get.back();
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<Message> updateDataCuti(Cuti cuti, int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.post("$baseUrl/cuti/update/" + id.toString(),
        body: {'dari': cuti.dari, 'sampai': cuti.sampai, 'alasan': cuti.alasan},
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      Get.back();
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }

  Future<Message> deleteCuti(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    final response = await http.get("$baseUrl/cuti/delete/" + id.toString(),
        headers: {'Accept': 'application/json', 'Authorization': token});

    if (response.statusCode == 200) {
      return null;
    } else {
      return Responses().messageFromJson(response.body);
    }
  }
}

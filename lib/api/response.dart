import 'dart:convert';

import 'package:siepegawai/controllers/logincontroller.dart';
import 'package:siepegawai/model/cuti.dart';
import 'package:siepegawai/model/homeadmin.dart';
import 'package:siepegawai/model/homepegawai.dart';
import 'package:siepegawai/model/message.dart';
import 'package:siepegawai/model/pengumuman.dart';
import 'package:siepegawai/model/pengumumandetail.dart';
import 'package:siepegawai/model/profile.dart';
import 'package:siepegawai/model/reimbursement.dart';
import 'package:siepegawai/model/user.dart';

class Responses {
  LoginClass loginFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return LoginClass.fromJson(data);
  }

  Message messageFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return Message.fromJson(data);
  }

  ProfileClass profileFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return ProfileClass.fromJson(data);
  }

  UserClass userFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return UserClass.fromJson(data);
  }

  AllUserClass allUserFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return AllUserClass.fromJson(data);
  }

  PengumumanClass pengumumanFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return PengumumanClass.fromJson(data);
  }

  PengumumanDetailClass pengumumanDetailFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return PengumumanDetailClass.fromJson(data);
  }

  HomeAdminClass homeAdminFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return HomeAdminClass.fromJson(data);
  }

  HomePegawaiClass homePegawaiFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return HomePegawaiClass.fromJson(data);
  }

  ReimbursementClass reimbursementFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return ReimbursementClass.fromJson(data);
  }

  ReimbursementDetailClass reimbursementDetailFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return ReimbursementDetailClass.fromJson(data);
  }

  CutiClass cutiFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return CutiClass.fromJson(data);
  }

  CutiDetailClass cutiDetailFromJson(String jsonData) {
    var data = json.decode(jsonData);
    return CutiDetailClass.fromJson(data);
  }
}

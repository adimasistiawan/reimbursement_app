class HomeAdminClass {
  int success;
  String message;
  HomeAdmin data;

  HomeAdminClass({this.success, this.message, this.data});

  HomeAdminClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new HomeAdmin.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class HomeAdmin {
  User user;
  int reimbursement;
  int cuti;

  HomeAdmin({this.user, this.reimbursement, this.cuti});

  HomeAdmin.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    reimbursement = json['reimbursement'];
    cuti = json['cuti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['reimbursement'] = this.reimbursement;
    data['cuti'] = this.cuti;
    return data;
  }
}

class User {
  int id;
  String nama;
  String email;
  String alamat;
  String noHp;
  String password;
  String status;

  User(
      {this.id,
      this.nama,
      this.email,
      this.alamat,
      this.noHp,
      this.password,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    alamat = json['alamat'];
    noHp = json['no_hp'];
    password = json['password'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['alamat'] = this.alamat;
    data['no_hp'] = this.noHp;
    data['password'] = this.password;
    data['status'] = this.status;
    return data;
  }
}

class ProfileClass {
  int success;
  String message;
  Data data;

  ProfileClass({this.success, this.message, this.data});

  ProfileClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int id;
  String nama;
  String email;
  String alamat;
  String noHp;
  String password;
  String divisi;
  String status;

  Data(
      {this.id,
      this.nama,
      this.email,
      this.alamat,
      this.noHp,
      this.password,
      this.divisi,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    alamat = json['alamat'];
    noHp = json['no_hp'];
    password = json['password'];
    divisi = json['divisi'];
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
    data['divisi'] = this.divisi;
    data['status'] = this.status;
    return data;
  }
}

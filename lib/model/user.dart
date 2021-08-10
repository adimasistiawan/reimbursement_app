class UserClass {
  int success;
  User data;

  UserClass({this.success, this.data});

  UserClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
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
  String divisi;
  String status;

  User(
      {this.id,
      this.nama,
      this.email,
      this.alamat,
      this.noHp,
      this.password,
      this.divisi,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
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

class AllUserClass {
  int success;
  List<AllUser> data;

  AllUserClass({this.success, this.data});

  AllUserClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<AllUser>();
      json['data'].forEach((v) {
        data.add(new AllUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllUser {
  int id;
  String nama;
  String email;
  String alamat;
  String noHp;
  String password;
  String divisi;
  String status;

  AllUser(
      {this.id,
      this.nama,
      this.email,
      this.alamat,
      this.noHp,
      this.password,
      this.divisi,
      this.status});

  AllUser.fromJson(Map<String, dynamic> json) {
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

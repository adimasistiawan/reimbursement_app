class HomePegawaiClass {
  int success;
  String message;
  Data data;

  HomePegawaiClass({this.success, this.message, this.data});

  HomePegawaiClass.fromJson(Map<String, dynamic> json) {
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
  User user;
  int reimbursement;
  int cuti;
  List<Pengumuman> pengumuman;
  Total total;

  Data({this.user, this.reimbursement, this.cuti, this.pengumuman, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    reimbursement = json['reimbursement'];
    cuti = json['cuti'];
    if (json['pengumuman'] != null) {
      pengumuman = new List<Pengumuman>();
      json['pengumuman'].forEach((v) {
        pengumuman.add(new Pengumuman.fromJson(v));
      });
    }
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['reimbursement'] = this.reimbursement;
    data['cuti'] = this.cuti;
    if (this.pengumuman != null) {
      data['pengumuman'] = this.pengumuman.map((v) => v.toJson()).toList();
    }
    if (this.total != null) {
      data['total'] = this.total.toJson();
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
  int dihapus;

  User(
      {this.id,
      this.nama,
      this.email,
      this.alamat,
      this.noHp,
      this.password,
      this.divisi,
      this.status,
      this.dihapus});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    alamat = json['alamat'];
    noHp = json['no_hp'];
    password = json['password'];
    divisi = json['divisi'];
    status = json['status'];
    dihapus = json['dihapus'];
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
    data['dihapus'] = this.dihapus;
    return data;
  }
}

class Pengumuman {
  int id;
  String judul;
  String isi;
  String tanggal;

  Pengumuman({this.id, this.judul, this.isi, this.tanggal});

  Pengumuman.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    isi = json['isi'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['tanggal'] = this.tanggal;
    return data;
  }
}

class Total {
  int total;
  int telahDiterima;
  int belumDikonfirmasi;
  int ditolak;

  Total({this.total, this.telahDiterima, this.belumDikonfirmasi, this.ditolak});

  Total.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    telahDiterima = json['telah_diterima'];
    belumDikonfirmasi = json['belum_dikonfirmasi'];
    ditolak = json['ditolak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['telah_diterima'] = this.telahDiterima;
    data['belum_dikonfirmasi'] = this.belumDikonfirmasi;
    data['ditolak'] = this.ditolak;
    return data;
  }
}

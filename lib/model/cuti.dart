class CutiClass {
  int success;
  List<Cuti> data;

  CutiClass({this.success, this.data});

  CutiClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Cuti>();
      json['data'].forEach((v) {
        data.add(new Cuti.fromJson(v));
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

class Cuti {
  int id;
  String kode;
  int userId;
  String tanggalPengajuan;
  String tanggalKonfirmasi;
  String dari;
  String sampai;
  String alasan;
  String alasanDitolak;
  String status;
  int dilihat;
  String nama;

  Cuti(
      {this.id,
      this.kode,
      this.userId,
      this.tanggalPengajuan,
      this.tanggalKonfirmasi,
      this.dari,
      this.sampai,
      this.alasan,
      this.alasanDitolak,
      this.status,
      this.dilihat,
      this.nama});

  Cuti.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    userId = json['user_id'];
    tanggalPengajuan = json['tanggal_pengajuan'];
    tanggalKonfirmasi = json['tanggal_konfirmasi'];
    dari = json['dari'];
    sampai = json['sampai'];
    alasan = json['alasan'];
    alasanDitolak = json['alasan_ditolak'];
    status = json['status'];
    dilihat = json['dilihat'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode'] = this.kode;
    data['user_id'] = this.userId;
    data['tanggal_pengajuan'] = this.tanggalPengajuan;
    data['tanggal_konfirmasi'] = this.tanggalKonfirmasi;
    data['dari'] = this.dari;
    data['sampai'] = this.sampai;
    data['alasan'] = this.alasan;
    data['alasan_ditolak'] = this.alasanDitolak;
    data['status'] = this.status;
    data['dilihat'] = this.dilihat;
    data['nama'] = this.nama;
    return data;
  }
}

class CutiDetailClass {
  int success;
  CutiDetail data;

  CutiDetailClass({this.success, this.data});

  CutiDetailClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new CutiDetail.fromJson(json['data']) : null;
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

class CutiDetail {
  int id;
  String kode;
  int userId;
  String tanggalPengajuan;
  String tanggalKonfirmasi;
  String dari;
  String sampai;
  String alasan;
  String alasanDitolak;
  String status;
  int dilihat;
  String nama;

  CutiDetail(
      {this.id,
      this.kode,
      this.userId,
      this.tanggalPengajuan,
      this.tanggalKonfirmasi,
      this.dari,
      this.sampai,
      this.alasan,
      this.alasanDitolak,
      this.status,
      this.dilihat,
      this.nama});

  CutiDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    userId = json['user_id'];
    tanggalPengajuan = json['tanggal_pengajuan'];
    tanggalKonfirmasi = json['tanggal_konfirmasi'];
    dari = json['dari'];
    sampai = json['sampai'];
    alasan = json['alasan'];
    alasanDitolak = json['alasan_ditolak'];
    status = json['status'];
    dilihat = json['dilihat'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode'] = this.kode;
    data['user_id'] = this.userId;
    data['tanggal_pengajuan'] = this.tanggalPengajuan;
    data['tanggal_konfirmasi'] = this.tanggalKonfirmasi;
    data['dari'] = this.dari;
    data['sampai'] = this.sampai;
    data['alasan'] = this.alasan;
    data['alasan_ditolak'] = this.alasanDitolak;
    data['status'] = this.status;
    data['dilihat'] = this.dilihat;
    data['nama'] = this.nama;
    return data;
  }
}

class ReimbursementClass {
  int success;
  List<ReimbursementAll> data;

  ReimbursementClass({this.success, this.data});

  ReimbursementClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<ReimbursementAll>();
      json['data'].forEach((v) {
        data.add(new ReimbursementAll.fromJson(v));
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

class ReimbursementAll {
  int id;
  int userId;
  String tanggalPengajuan;
  String tanggalKonfirmasi;
  String buktiPembayaran;
  String keterangan;
  String alasanDitolak;
  String status;
  String kode;
  int dilihat;
  int nominal;
  String nama;

  ReimbursementAll(
      {this.id,
      this.userId,
      this.tanggalPengajuan,
      this.tanggalKonfirmasi,
      this.buktiPembayaran,
      this.keterangan,
      this.alasanDitolak,
      this.status,
      this.kode,
      this.dilihat,
      this.nominal,
      this.nama});

  ReimbursementAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tanggalPengajuan = json['tanggal_pengajuan'];
    tanggalKonfirmasi = json['tanggal_konfirmasi'];
    buktiPembayaran = json['bukti_pembayaran'];
    keterangan = json['keterangan'];
    alasanDitolak = json['alasan_ditolak'];
    status = json['status'];
    kode = json['kode'];
    dilihat = json['dilihat'];
    nominal = json['nominal'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['tanggal_pengajuan'] = this.tanggalPengajuan;
    data['tanggal_konfirmasi'] = this.tanggalKonfirmasi;
    data['bukti_pembayaran'] = this.buktiPembayaran;
    data['keterangan'] = this.keterangan;
    data['alasan_ditolak'] = this.alasanDitolak;
    data['status'] = this.status;
    data['kode'] = this.kode;
    data['dilihat'] = this.dilihat;
    data['nominal'] = this.nominal;
    data['nama'] = this.nama;
    return data;
  }
}

class ReimbursementDetailClass {
  int success;
  ReimbursementDetail data;

  ReimbursementDetailClass({this.success, this.data});

  ReimbursementDetailClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new ReimbursementDetail.fromJson(json['data'])
        : null;
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

class ReimbursementDetail {
  int id;
  int userId;
  String tanggalPengajuan;
  String tanggalKonfirmasi;
  String buktiPembayaran;
  String keterangan;
  String alasanDitolak;
  String status;
  String kode;
  int dilihat;
  int nominal;
  String nama;

  ReimbursementDetail(
      {this.id,
      this.userId,
      this.tanggalPengajuan,
      this.tanggalKonfirmasi,
      this.buktiPembayaran,
      this.keterangan,
      this.alasanDitolak,
      this.status,
      this.kode,
      this.dilihat,
      this.nominal,
      this.nama});

  ReimbursementDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tanggalPengajuan = json['tanggal_pengajuan'];
    tanggalKonfirmasi = json['tanggal_konfirmasi'];
    buktiPembayaran = json['bukti_pembayaran'];
    keterangan = json['keterangan'];
    alasanDitolak = json['alasan_ditolak'];
    status = json['status'];
    kode = json['kode'];
    dilihat = json['dilihat'];
    nominal = json['nominal'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['tanggal_pengajuan'] = this.tanggalPengajuan;
    data['tanggal_konfirmasi'] = this.tanggalKonfirmasi;
    data['bukti_pembayaran'] = this.buktiPembayaran;
    data['keterangan'] = this.keterangan;
    data['alasan_ditolak'] = this.alasanDitolak;
    data['status'] = this.status;
    data['kode'] = this.kode;
    data['dilihat'] = this.dilihat;
    data['nominal'] = this.nominal;
    data['nama'] = this.nama;
    return data;
  }
}

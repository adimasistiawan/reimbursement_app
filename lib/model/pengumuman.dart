class PengumumanClass {
  int success;
  List<Pengumuman> data;

  PengumumanClass({this.success, this.data});

  PengumumanClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Pengumuman>();
      json['data'].forEach((v) {
        data.add(new Pengumuman.fromJson(v));
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

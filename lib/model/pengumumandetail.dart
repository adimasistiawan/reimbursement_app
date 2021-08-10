class PengumumanDetailClass {
  int success;
  PengumumanDetail data;

  PengumumanDetailClass({this.success, this.data});

  PengumumanDetailClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new PengumumanDetail.fromJson(json['data'])
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

class PengumumanDetail {
  int id;
  String judul;
  String isi;
  String tanggal;

  PengumumanDetail({this.id, this.judul, this.isi, this.tanggal});

  PengumumanDetail.fromJson(Map<String, dynamic> json) {
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

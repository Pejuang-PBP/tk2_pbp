// ignore: file_names
// ignore: file_names
class UTD {
  final int id;
  final String nama;
  final String kota;
  final String alamat;
  final String jamOperasi;
  final int nomorTelepon;

  UTD(
      {required this.id,
      required this.nama,
      required this.kota,
      required this.alamat,
      required this.jamOperasi,
      required this.nomorTelepon});

  // ignore: empty_constructor_bodies
  factory UTD.fromMap(Map<String, dynamic> map) {
    return UTD(
      id: map['id'],
      nama: map["nama"],
      kota: map["kota"],
      alamat: map["alamat"],
      jamOperasi: map["jamOperasi"],
      nomorTelepon: map["nomorTelepon"],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'kota': kota,
        'alamat': alamat,
        'jamOperasi': jamOperasi,
        'nomorTelepon': nomorTelepon,
      };
}

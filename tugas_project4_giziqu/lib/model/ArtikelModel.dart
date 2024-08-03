// ignore_for_file: non_constant_identifier_names, file_names

class Artikel {
  final String deskripsi;
  final String foto;
  final String id;
  final String jenis;
  final String link;
  final String nama_artikel;

  Artikel({
    required this.deskripsi,
    required this.foto,
    required this.id,
    required this.jenis,
    required this.link,
    required this.nama_artikel,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      deskripsi: json['deskripsi'] ?? '',
      foto: json['foto'] ?? '',
      id: json['id'] ?? {},
      jenis: json['jenis'] ?? '',
      link: json['link'] ?? '',
      nama_artikel: json['nama_artikel'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deskripsi': deskripsi,
      'foto': foto,
      'id': id,
      'jenis': jenis,
      'link': link,
      'nama_artikel': nama_artikel,
    };
  }
}

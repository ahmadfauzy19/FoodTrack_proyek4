class Makanan {
  final String namaMakanan;
  final String foto;
  final Map<String, dynamic> gizi;
  final String jenis;

  Makanan({
    required this.namaMakanan,
    required this.foto,
    required this.gizi,
    required this.jenis,
  });

  factory Makanan.fromJson(Map<String, dynamic> json) {
    return Makanan(
      namaMakanan: json['nama_makanan'] ?? '',
      foto: json['foto'] ?? '',
      gizi: json['gizi'] ?? {},
      jenis: json['jenis'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_makanan': namaMakanan,
      'foto': foto,
      'gizi': gizi,
      'jenis': jenis,
    };
  }
}

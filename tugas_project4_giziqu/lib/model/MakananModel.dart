class Makanan {
  final String namaMakanan;
  final String foto;
  final Map<String, dynamic> gizi;
  final String jenis;
  final Map<String, dynamic> label_gizi;

  Makanan({
    required this.namaMakanan,
    required this.foto,
    required this.gizi,
    required this.jenis,
    required this.label_gizi,
  });

  factory Makanan.fromJson(Map<String, dynamic> json) {
    return Makanan(
      namaMakanan: json['nama_makanan'] ?? '',
      foto: json['foto'] ?? '',
      gizi: json['gizi'] ?? {},
      jenis: json['jenis'] ?? '',
      label_gizi: json['label_gizi'] ?? '',
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

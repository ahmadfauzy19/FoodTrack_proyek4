import 'package:flutter/material.dart';

class KelolaArtikel extends StatefulWidget {
  const KelolaArtikel({Key? key}) : super(key: key);

  @override
  State<KelolaArtikel> createState() => _KelolaArtikelState();
}

class _KelolaArtikelState extends State<KelolaArtikel> {
  List<Map<String, String>> artikelList = [
    {
      'judul artikel': 'Cara Diet Tanpa Menyiksa Tubuh',
      'jenis': 'Tutorial',
    },
    {
      'judul artikel': 'Tips Memilih Makanan Sesuai Dengan Kondisi Tubuh',
      'jenis': 'Tutorial',
    },
    {
      'judul artikel': 'Review Makanan Kemasana yang katanya "sehat"',
      'jenis': 'makan',
    },
    {
      'judul artikel': 'Review Makanan Kemasana yang katanya "sehat"',
      'jenis': 'makan',
    },
    {
      'judul artikel': 'Review Makanan Kemasana yang katanya "sehat"',
      'jenis': 'makan',
    },
    {
      'judul artikel': 'Review Makanan Kemasana yang katanya "sehat"',
      'jenis': 'makan',
    },
    {
      'judul artikel': 'Review Makanan Kemasana yang katanya "sehat"',
      'jenis': 'makan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kelola Artikel"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: DataTable(
              horizontalMargin: 10,
              columns: [
                DataColumn(
                  label: Text(
                    'Judul Artikel',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Jenis',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Aksi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
              rows: artikelList.map((item) {
                return DataRow(
                  cells: [
                    DataCell(
                      Center(
                        child: Text(
                            item['judul artikel'] ?? 'Judul tidak tersedia'),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(item['jenis'] ?? 'Jenis tidak tersedia'),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

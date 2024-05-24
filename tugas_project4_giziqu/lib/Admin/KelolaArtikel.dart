// ignore_for_file: file_names

import 'package:flutter/material.dart';

class KelolaArtikel extends StatefulWidget {
  const KelolaArtikel({Key? key}) : super(key: key);

  @override
  State<KelolaArtikel> createState() => _KelolaArtikelState();
}

class _KelolaArtikelState extends State<KelolaArtikel> {
  final List<Map<String, String>> artikelList = [
    {'judulartikel': 'Sebagai Manusia Perlu Berpikir', 'jenis': 'Pemikiran'},
    {'judulartikel': 'Makanan Sehat untuk Otak', 'jenis': 'Kesehatan'},
    {'judulartikel': 'Belajar dari Kegagalan', 'jenis': 'Pembelajaran'},
  ];

  Widget buildTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        buildTableRow(['Judul Artikel', 'Jenis', 'Aksi'], isHeader: true),
        for (var artikel in artikelList)
          buildTableRow(
              [artikel['judulartikel']!, artikel['jenis']!, buildActionCell()])
      ],
    );
  }

  TableRow buildTableRow(List<dynamic> cells, {bool isHeader = false}) {
    final cellStyle =
        TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);
    return TableRow(
      children: cells.map((cell) {
        if (cell is String) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                cell,
                style: cellStyle,
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: cell),
          );
        }
      }).toList(),
    );
  }

  Widget buildActionCell() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            color: Colors.blue,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelola Artikel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          child: buildTable(),
        ),
      ),
    );
  }
}

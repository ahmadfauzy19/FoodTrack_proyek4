import 'package:flutter/material.dart';

class KelolaMakanan extends StatefulWidget {
  const KelolaMakanan({super.key});

  @override
  State<KelolaMakanan> createState() => _KelolaMakananState();
}

class _KelolaMakananState extends State<KelolaMakanan> {
  List<Map<String, String>> makananList = [
    {
      'idmakanan': '1',
      'nama makanan': 'Nasi Goreng',
      'jenis': 'Makanan Utama',
    },
    {
      'idmakanan': '2',
      'nama makanan': 'Ayam Bakar',
      'jenis': 'Makanan Utama',
    },
    {
      'idmakanan': '3',
      'nama makanan': 'Es Teh',
      'jenis': 'Minuman',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kelola Makanan"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.grey),
          child: Table(
            border: TableBorder.all(borderRadius: BorderRadius.circular(15)),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Text(
                      "ID Makanan",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text("Nama Makanan", textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text("Jenis", textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text("Aksi", textAlign: TextAlign.center),
                  ),
                ],
              ),
              for (var item in makananList)
                TableRow(children: [
                  TableCell(child: Text(item['idmakanan']!)),
                  TableCell(child: Text(item['nama makanan']!)),
                  TableCell(child: Text(item['jenis']!)),
                  TableCell(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
                          )
                        ],
                      ),
                    ),
                  )
                ])
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print, unused_field, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'EditMakanan.dart';
import '../global/LoadingProgress.dart';

// import '../global/DataMakanan.dart';
import '../global/link.dart';

class KelolaMakanan extends StatefulWidget {
  const KelolaMakanan({Key? key}) : super(key: key);

  @override
  State<KelolaMakanan> createState() => _KelolaMakananState();
}

class _KelolaMakananState extends State<KelolaMakanan> {
  List<Map<String, dynamic>> _makananList = [];
  bool _isLoading =
      true; // Menandakan apakah sedang dalam proses loading atau tidak

  @override
  void initState() {
    super.initState();
    getDataMakanan();
  }

  Future<void> getDataMakanan() async {
    final Uri uri = Uri.parse('${link}api/makanan/read_makanan');

    try {
      const LoadingDialog(pesan: "menghapus data");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          _makananList =
              responseData.values.toList().cast<Map<String, dynamic>>();
          _isLoading = false;
        });
        // Cetak _makananList setelah diperbarui
        print(_makananList);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      _showDialog('Error occurred: $error');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informasi'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteItem(String id) async {
    // Menghapus item dari list
    final Uri uri = Uri.parse("${link}api/makanan/delete_makanan?id=$id");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        _makananList.removeWhere((item) => item['barcode'] == id);
      });
    }

    Navigator.of(context).pop();
  }

  Future<void> _showDeleteConfirmation(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _deleteItem(id),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
          color: const Color.fromARGB(255, 63, 181, 69),
          child: const LoadingDialog(pesan: "mengambil data makanan"));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Kelola Makanan"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: DataTable(
                    columnSpacing: 20, // Mengatur jarak antar kolom
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Barcode',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Nama Makanan',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Jenis Makanan',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Aksi',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    // ignore: deprecated_member_use
                    dataRowHeight: 60, // Mengatur tinggi setiap baris
                    rows: _makananList
                        .map(
                          (item) => DataRow(cells: [
                            DataCell(Text(item['barcode'].toString())),
                            DataCell(Text(item['nama_makanan'])),
                            DataCell(Text(item['jenis'])),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditMakanan(
                                              barcode: item['barcode']),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: Colors.blue,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _showDeleteConfirmation(item['barcode']);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}

// ignore_for_file: unnecessary_const, avoid_print, file_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global/link.dart';
import '../global/LoadingProgress.dart';
import 'EditArtikel.dart';

class KelolaArtikel extends StatefulWidget {
  const KelolaArtikel({Key? key}) : super(key: key);

  @override
  State<KelolaArtikel> createState() => _KelolaArtikelState();
}

class _KelolaArtikelState extends State<KelolaArtikel> {
  List<dynamic> _artikelList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getDataArtikel();
  }

  Future<void> getDataArtikel() async {
    try {
      final response =
          await http.get(Uri.parse('${link}api/read_semua_artikel_makanan'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        setState(() {
          _artikelList =
              responseData.where((element) => element != null).toList();
          _isLoading = false;
        });
        print(_artikelList);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      _showDialog('Error occurred: $error');
    }
  }

  Future<void> _deleteItem(String id) async {
    final Uri uri = Uri.parse("${link}api/delete_artikel_makanan?id=$id");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        _artikelList.removeWhere((item) => item['id'] == id);
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
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
              onPressed: () => _deleteItem(id),
            ),
          ],
        );
      },
    );
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

  Widget buildTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        buildTableRow(['Judul Artikel', 'Jenis', 'Aksi'], isHeader: true),
        for (var artikel in _artikelList)
          buildTableRow(
            [
              artikel['nama_artikel'],
              artikel['jenis'],
              buildActionCell(artikel['id'])
            ],
          )
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

  Widget buildActionCell(String id) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditArtikel(id: id),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            color: Colors.blue,
          ),
          IconButton(
            onPressed: () {
              _showDeleteConfirmation(id);
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: const Color.fromARGB(255, 63, 181, 69),
        child: const LoadingDialog(
          pesan: "sedang mengambil data",
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Kelola Artikel"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: buildTable(),
          ),
        ),
      );
    }
  }
}

// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, avoid_print, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tugas_project4_giziqu/global/link.dart';
import 'package:tugas_project4_giziqu/user/Scanresult.dart';
import 'package:http/http.dart' as http;

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String _barcodeScanRes =
      ''; // Variabel untuk menyimpan hasil pemindaian barcode
  // ignore: unused_field
  bool _isScanning =
      false; // Menandakan apakah pemindaian barcode sedang berlangsung

  // Method untuk memulai pemindaian barcode
  Future<void> _startBarcodeScan() async {
    setState(() {
      _isScanning =
          true; // Setel _isScanning menjadi true saat pemindaian dimulai
    });

    // Tampilkan dialog dengan tombol tambahan

    try {
      // Mulai pemindaian barcode
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Batal',
        true,
        ScanMode.BARCODE,
      );

      final Uri uri = Uri.parse(
          "${link}api/makanan/search_makanan_barcode?keyword=$barcodeScanRes");

      try {
        var response = await http.get(uri);
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          // ignore: avoid_print
          print(data);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scanresult(
                      data: data,
                    )), // Perubahan di sini
          );
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        // ignore: avoid_print
        print('Exception: $e');
      }

      setState(() {
        _barcodeScanRes = barcodeScanRes; // Simpan hasil pemindaian barcode
        _isScanning =
            false; // Setel _isScanning menjadi false setelah pemindaian selesai
      });
    } on PlatformException {
      setState(() {
        _barcodeScanRes = 'Failed to scan barcode.';
        _isScanning =
            false; // Setel _isScanning menjadi false dalam kasus pemindaian gagal
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Column(
                children: [
                  const Text(
                    'Hasil Pemindaian Barcode:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _barcodeScanRes,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Pengingat"),
                  Text(
                      "Pastikan Scan barcode sesuai dengan posisinya dan pastikan koneksi Internet lancar"),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Scan Barcode",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Scan Barang",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // Tambahkan tombol untuk memulai pemindaian barcode
      floatingActionButton: FloatingActionButton(
        onPressed: _startBarcodeScan,
        backgroundColor: Colors.green,
        shape:
            const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
        child: const Icon(
          Icons.qr_code_scanner_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//  _startBarcodeScan,
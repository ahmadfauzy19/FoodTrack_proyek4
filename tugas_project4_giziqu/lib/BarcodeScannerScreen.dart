// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, avoid_print, avoid_unnecessary_containers, library_private_types_in_public_api, use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/model/MakananModel.dart';
import 'package:tugas_project4_giziqu/services/makanan_service.dart';
import 'package:tugas_project4_giziqu/user/ScanBarangPage.dart';
import 'package:tugas_project4_giziqu/user/Scanresult.dart'; // Tambahkan import

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final String _barcodeScanRes = '';
  bool _isScanning = false;
  List<Makanan> _makananList = [];

  Future<void> _startBarcodeScan() async {
    setState(() {
      _isScanning = true;
    });

    try {
      List<Makanan> scannedMakananList = await MakananService.scanBarcode();
      setState(() {
        _makananList = scannedMakananList;
        _isScanning = false;
      });

      if (_makananList.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Scanresult(
                    data: scannedMakananList,
                  )),
        );
      } else {
        print('No items found');
      }
    } catch (e) {
      setState(() {
        _isScanning = false;
      });
      print('Exception: $e');
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScanBarangPage()),
                      );
                    },
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

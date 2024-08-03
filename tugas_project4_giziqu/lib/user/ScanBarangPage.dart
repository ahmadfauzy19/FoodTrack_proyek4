// ignore_for_file: unused_element, avoid_print, avoid_unnecessary_containers, file_names, use_build_context_synchronously, unused_import, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_project4_giziqu/BarcodeScannerScreen.dart';
import 'package:tugas_project4_giziqu/global/bottom_app_bar/bottom_app_bar_widget.dart';
import 'package:tugas_project4_giziqu/global/link.dart';
import 'package:tugas_project4_giziqu/model/MakananModel.dart';
import 'package:tugas_project4_giziqu/services/makanan_service.dart';
import 'package:tugas_project4_giziqu/user/Scanresult.dart';

class ScanBarangPage extends StatefulWidget {
  const ScanBarangPage({super.key});

  @override
  State<ScanBarangPage> createState() => _ScanBarangPageState();
}

class _ScanBarangPageState extends State<ScanBarangPage> {
  File? _pickedImage;
  bool _isScanning = false;
  List<Makanan> makananList = [];
  String _detectionLabel = 'Pilih gambar untuk mendeteksi';

  Future<void> _search(String keyword) async {
    setState(() {
      _isScanning = true;
    });
    try {
      List<Makanan> scanMakananList =
          await MakananService.searchMakanan(keyword);
      setState(() {
        makananList = scanMakananList;
        _isScanning = false;
      });

      if (makananList.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scanresult(data: makananList),
          ),
        );
      } else {
        print('Data makanan tidak ditemukan');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Data makanan tidak ditemukan',
              style: TextStyle(color: Colors.white), // Warna teks konten
            ),
            backgroundColor: const Color(0xFFB71C1C), // Warna merah gelap
            action: SnackBarAction(
              label: 'Tutup',
              onPressed: () {},
              textColor: Colors.yellow, // Warna teks tombol aksi
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isScanning = false;
      });
      print('Exception saat searching makanan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Exception saat searching makanan: $e',
            style: const TextStyle(color: Colors.white), // Warna teks konten
          ),
          backgroundColor: const Color(0xFFB71C1C), // Warna merah gelap
          action: SnackBarAction(
            label: 'Tutup',
            onPressed: () {},
            textColor: Colors.yellow, // Warna teks tombol aksi
          ),
        ),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });

      // Jika gambar dipilih, kirim permintaan POST
      await _sendImage();
    } else {
      // User membatalkan pengambilan gambar dari galeri
    }
  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });

      // Jika gambar dipilih, kirim permintaan POST
      await _sendImage();
    } else {
      // User membatalkan pengambilan gambar dari kamera
    }
  }

  Future<void> _sendImage() async {
    try {
      if (_pickedImage == null) {
        return;
      }

      // Buat objek request multipart
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${link_yolo}/predict'), // Ganti URL dengan URL endpoint Anda
      );
      // Tambahkan file ke bagian request multipart
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // Nama parameter yang diharapkan oleh server
          _pickedImage!.path, // Path dari file yang akan diunggah
        ),
      );

      // Kirim permintaan ke server dan tanggapi respons
      var response = await request.send();

      // Baca respons dari server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);

      // Ambil label dari respons
      var decodedResponse = json.decode(responseString);
      var detectionLabel = decodedResponse['detection_label'] as String;

      // Update state dengan label deteksi
      setState(() {
        _detectionLabel = detectionLabel;
      });
      await _search(detectionLabel);
    } catch (e) {
      // Tangkap dan tampilkan error jika terjadi masalah
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: _isScanning
            ? const CircularProgressIndicator(
                color: Colors.orange,
              )
            : Column(
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
                        Text(_detectionLabel),
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
                            "Pastikan foto yang diambil jelas dan pastikan koneksi Internet lancar"),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BarcodeScannerScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            "Scan Barcode",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            "Scan Barang",
                            style: TextStyle(color: Colors.white),
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
        onPressed: _pickImageFromCamera,
        backgroundColor: Colors.green,
        shape:
            const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
        child: const Icon(
          Icons.qr_code_scanner_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}

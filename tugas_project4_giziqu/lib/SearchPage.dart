// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, avoid_print, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/global/LoadingProgress.dart';
import 'package:tugas_project4_giziqu/model/MakananModel.dart';
import 'package:tugas_project4_giziqu/user/Scanresult.dart';
import 'package:tugas_project4_giziqu/services/makanan_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  Future<void> _search(String keyword) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog(pesan: "Mengambil data.");
      },
    );
    try {
      List<Makanan> makananList = await MakananService.searchMakanan(keyword);
      Navigator.pop(context);
      if (makananList.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scanresult(data: makananList),
          ),
        );
      } else {
        // Navigator.pop(context);
        print('Data makanan tidak ditemukan');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Data makanan tidak ditemukan'),
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
      print('Exception saat searching makanan: $e');
      // Tambahkan handling exception, misalnya dengan menampilkan snackbar atau dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exception saat searching makanan: $e'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Cari Makanan',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Nama Makanan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String keyword = _searchController.text.trim();
                if (keyword.isNotEmpty) {
                  _search(keyword);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}

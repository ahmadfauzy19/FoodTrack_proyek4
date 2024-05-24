import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_project4_giziqu/user/Scanresult.dart';
import 'global/link.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  Future<void> _search(String keyword) async {
    // Ganti URL_API dengan URL endpoint API yang sesuai
    final Uri uri =
        Uri.parse("${link}api/makanan/search_makanan?keyword=$keyword");

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
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
      print('Exception: $e');
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

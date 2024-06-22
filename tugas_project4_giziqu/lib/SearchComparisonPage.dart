import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/global/link.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_project4_giziqu/model/MakananModel.dart';
import 'package:tugas_project4_giziqu/services/makanan_service.dart';
import 'package:tugas_project4_giziqu/user/ComparisonPage.dart';

class SearchComparisonPage extends StatefulWidget {
  final List<Makanan> data;

  const SearchComparisonPage({Key? key, required this.data}) : super(key: key);

  @override
  _SearchComparisonPageState createState() => _SearchComparisonPageState();
}

class _SearchComparisonPageState extends State<SearchComparisonPage> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> _search(String keyword) async {
    try {
      List<Makanan> makananList = await MakananService.searchMakanan(keyword);
      if (makananList.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComparisonPage(
              data: makananList,
              data2: widget.data,
            ),
          ),
        );
      } else {
        print('Data makanan tidak ditemukan');
        // Handle ketika data makanan tidak ditemukan, misalnya dengan menampilkan snackbar atau dialog
      }
    } catch (e) {
      print('Exception saat searching makanan: $e');
      // Handle exception, misalnya dengan menampilkan snackbar atau dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Bandingkan Produk',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20.0),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Nama Makanan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        prefixIcon: Icon(Icons.search), // Icon search di sini
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                ],
              ),
            ),
            SizedBox(height: 80.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: ElevatedButton(
                onPressed: () {
                  _search(_searchController.text);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

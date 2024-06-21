// ignore_for_file: file_names, avoid_print, library_private_types_in_public_api, sized_box_for_whitespace, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tugas_project4_giziqu/user/LandingPage.dart';
import 'package:tugas_project4_giziqu/user/ProfilePage.dart';
import 'SearchPage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:tugas_project4_giziqu/global/link.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodImage extends StatelessWidget {
  final String imageUrl;

  const FoodImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getImageDownloadUrl(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Image.network(snapshot.data!);
        } else {
          return const Text('No image available');
        }
      },
    );
  }

  Future<String> getImageDownloadUrl() async {
    try {
      final downloadUrl = await firebase_storage.FirebaseStorage.instance
          .ref('Images/ArtikelImage/$imageUrl')
          .getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting download URL: $e');
      rethrow;
    }
  }
}

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Map<String, dynamic>> _newsData = [];
  bool _isLoading =
      true; // Menandakan apakah sedang dalam proses loading atau tidak

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  // Fungsi untuk mengambil data dari API
  Future<void> _fetchNews() async {
    final response =
        await http.get(Uri.parse('${link}api/read_semua_artikel_makanan'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Map<String, dynamic>> filteredData = responseData
          .where((data) => data != null)
          .cast<Map<String, dynamic>>()
          .toList();

      setState(() {
        _newsData = filteredData;
        _isLoading =
            false; // Setelah data terambil, tidak lagi dalam proses loading
      });
      // Cetak _newsData setelah diperbarui
      print(_newsData);
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
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
        title: const Text("Berita"),
      ),
      body: _isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(), // Tampilkan loading indicator jika data belum termuat
            )
          : ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Paling Populer",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      child: PageView(
                        children: _buildPopularNews(context),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Terkini",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildLatestNews(context),
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.white, width: 2),
        ),
        child: const Icon(
          Icons.qr_code_scanner_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                );
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                // Tambahkan logika untuk navigasi ke halaman berita
              },
              icon: const Icon(Icons.newspaper),
            ),
            const SizedBox(width: 50),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPopularNews(BuildContext context) {
    List<Widget> popularNewsWidgets = [];
    if (_newsData.isNotEmpty) {
      for (int i = 0; i < _newsData.length; i++) {
        if (_newsData[i] != null) {
          popularNewsWidgets.add(_buildNewsCard(
            context,
            image: _newsData[i]['foto'],
            title: _newsData[i]['nama_artikel'],
            url: _newsData[i]['link'],
          ));
        }
      }
    }
    return popularNewsWidgets;
  }

  Widget _buildLatestNews(BuildContext context) {
    List<Widget> latestNewsWidgets = [];
    if (_newsData.isNotEmpty) {
      for (int i = 0; i < _newsData.length; i++) {
        if (_newsData[i] != null) {
          latestNewsWidgets.add(_buildLatestNewsItem(
            context,
            image: _newsData[i]['foto'],
            title: _newsData[i]['nama_artikel'],
            content: _newsData[i]['deskripsi'],
            url: _newsData[i]['link'],
          ));
        }
      }
    }
    return Column(
      children: latestNewsWidgets,
    );
  }

  Widget _buildNewsCard(BuildContext context,
      {required String image, required String title, required String url}) {
    return GestureDetector(
      onTap: () {
        // Handle the tap gesture here
        _launchURL(url);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child:
                    FoodImage(imageUrl: image), // Menggunakan FoodImage di sini
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestNewsItem(BuildContext context,
      {required String image,
      required String title,
      required String content,
      required String url}) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              child: FoodImage(imageUrl: image), // Gunakan FoodImage di sini
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

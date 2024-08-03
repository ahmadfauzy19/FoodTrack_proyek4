// ignore_for_file: file_names, avoid_print, library_private_types_in_public_api, sized_box_for_whitespace, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/components/NewsImage.dart';
import 'package:tugas_project4_giziqu/global/LoadingProgress.dart';
import 'package:tugas_project4_giziqu/global/bottom_app_bar/bottom_app_bar_widget.dart';
import 'package:tugas_project4_giziqu/global/bottom_app_bar/floating_action_button_widget.dart';
import 'package:tugas_project4_giziqu/services/artikel_service.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Map<String, dynamic>> _newsData = [];
  final ArtikelServices _newsService = ArtikelServices();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  // Fungsi untuk mengambil data dari API
  Future<void> _fetchNews() async {
    try {
      final newsData = await _newsService.fetchNews();
      setState(() {
        _newsData = newsData;
        _isLoading =
            false; // Setelah data terambil, tidak lagi dalam proses loading
      });
      // Cetak _newsData setelah diperbarui
      print(_newsData);
    } catch (e) {
      print('Failed to load news: $e');
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
              child: LoadingDialog(pesan: "Mengambil data."),
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
      floatingActionButton: const FloatingActionButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBarWidget(),
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
                    NewsImage(imageUrl: image), // Menggunakan FoodImage di sini
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
              child: NewsImage(
                imageUrl: image,
                width: 120,
                height: 120,
              ), // Gunakan FoodImage di sini
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

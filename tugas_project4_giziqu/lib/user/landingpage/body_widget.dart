// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/services/artikel_service.dart';
import 'package:tugas_project4_giziqu/user/KebutuhanGiziPage.dart';
import 'package:tugas_project4_giziqu/user/landingpage/costom_divider_widget.dart';
import 'box_widget.dart';
import 'title_widget.dart';
import 'bottom_box_widget.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  ArtikelServices artikelServices = ArtikelServices();
  List<Map<String, dynamic>> _artikelData = [];

  @override
  void initState() {
    super.initState();
    _fetchArtikel();
  }

  Future<void> _fetchArtikel() async {
    try {
      Future<List<Map<String, dynamic>>> futureArtikel =
          artikelServices.fetchNews();
      futureArtikel.then((data) {
        setState(() {
          _artikelData = data;
        });
      });
    } catch (e) {
      print('Error fetching artikel: $e');
      // Handle error fetching artikel jika perlu
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      height: 576,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.10),
          topRight: Radius.circular(MediaQuery.of(context).size.width * 0.10),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          const TitleWidget(title: "Fast Menu"),
          _buildBoxesRow(),
          const SizedBox(height: 10),
          const CustomDividerWidget(),
          const SizedBox(height: 20),
          const TitleWidget(title: "Berita Terkini", showSeeAll: true),
          _buildTerkiniNews(), // Gunakan Expanded untuk ListView
        ],
      ),
    );
  }

  Widget _buildBoxesRow() {
    return Container(
      margin: const EdgeInsets.all(0),
      child: Row(
        children: [
          BoxWidget(
            color: const Color.fromARGB(203, 47, 205, 42),
            imagePath: "assets/kebutuhanGizi.png",
            text: "kebutuhan gizi",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KebutuhanGiziPage(),
                ),
              );
            },
          ),
          BoxWidget(
            color: const Color.fromARGB(203, 47, 205, 42),
            imagePath: "assets/kebutuhanGizi.png",
            text: "kebutuhan gizi",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KebutuhanGiziPage(),
                ),
              );
            },
          ),
          BoxWidget(
            color: const Color.fromARGB(203, 47, 205, 42),
            imagePath: "assets/kebutuhanGizi.png",
            text: "kebutuhan gizi",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KebutuhanGiziPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTerkiniNews() {
    if (_artikelData.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.orange,
      ));
    }

    List<Map<String, dynamic>> recentArticles = _artikelData.take(3).toList();

    return SizedBox(
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentArticles.length,
        itemBuilder: (context, index) {
          var artikel = recentArticles[index];
          return BottomBoxWidget(
            deskripsi: artikel['deskripsi'],
            image: artikel['foto'],
            judul: artikel['nama_artikel'],
            url: artikel['link'],
          );
        },
      ),
    );
  }
}

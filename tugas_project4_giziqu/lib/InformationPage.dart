import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/LoginPage.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key})
      : super(
            key: key ??
                const ValueKey("InformationPage")); // Memberikan key default

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  int _currentPageIndex = 0;

  final List<String> _texts = [
    "Memudahkan anda untuk mengetahui informasi gizi dari produk yang anda beli dengan hanya memindai barcode-nya",
    "Memberikan anda analisis lengkap tentang kandungan gizi dari makanan yang anda konsumsi",
    "Memberikan anda saran gizi yang sesuai dengan kebutuhan, preferensi, dan tujuan anda",
  ];

  final List<String> _imagePaths = [
    "assets/image1.jpg",
    "assets/image2.jpg",
    "assets/image3.jpg",
  ];

  final List<String> _titles = [
    "Pemindaian Barcode Produk",
    "Analisis Informasi Gizi",
    "Rekomendasi Gizi Personalisasi",
  ];

  _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _navigateToNextInfo() {
    setState(() {
      if (_currentPageIndex < _texts.length - 1) {
        _currentPageIndex++;
      } else {
        _navigateToLoginPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 200.0),
          Column(
            children: [
              Image.asset(
                _imagePaths[
                    _currentPageIndex], // Gunakan _currentPageIndex untuk memilih gambar yang sesuai
                height: 100,
                width: 100,
              ),
              SizedBox(height: 300), // Jarak antara gambar dan judul
              Text(
                _titles[
                    _currentPageIndex], // Menggunakan judul sesuai dengan indeks gambar saat ini
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 20), // Jarak antara gambar dan teks
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  _texts[_currentPageIndex],
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 80), // Jarak antara teks dan tombol
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentPageIndex =
                              (_currentPageIndex - 1).clamp(0, 2);
                        });
                      },
                      child: Text("Previous"),
                    ),
                    SizedBox(
                        width:
                            150), // Jarak antara tombol "Previous" dan "Next"
                    ElevatedButton(
                      onPressed: _navigateToNextInfo,
                      child: Text("Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

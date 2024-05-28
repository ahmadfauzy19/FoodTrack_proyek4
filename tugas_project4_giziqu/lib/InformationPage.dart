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
    "assets/gambar1.png",
    "assets/gambar2.png",
    "assets/gambar3.png",
  ];

  final List<String> _titles = [
    "Pemindaian Barcode Produk",
    "Analisis Informasi Gizi",
    "Rekomendasi Gizi Personalisasi",
  ];

  _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/frontbackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 90.0),
                Column(
                  children: [
                    Image.asset(
                      _imagePaths[_currentPageIndex],
                      height: 300,
                      width: 300,
                    ),
                    const SizedBox(height: 80),
                    Text(
                      _titles[_currentPageIndex],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _texts[_currentPageIndex],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.4,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _currentPageIndex =
                                (_currentPageIndex - 1).clamp(0, 2);
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          "Previous",
                          style: TextStyle(
                            color: Color.fromARGB(255, 17, 17, 17),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.4,
                      child: TextButton(
                        onPressed: _navigateToNextInfo,
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            color: Color.fromARGB(255, 32, 122, 8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

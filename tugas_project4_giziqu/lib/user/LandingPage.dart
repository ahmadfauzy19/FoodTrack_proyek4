import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/NewsPage.dart';
import 'package:tugas_project4_giziqu/SearchPage.dart';
import '../BarcodeScannerScreen.dart'; // Hanya butuh di sini, menghapus yang lain
import 'ProfilePage.dart';

class LandingPage extends StatefulWidget {
  final String username;
  final String name;
  const LandingPage({Key? key, required this.username, required this.name})
      : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 102, 183, 65),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/BG.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/default.jpeg"),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Selamat Datang,",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.name, // Gunakan nilai username dari widget
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                height: 576,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        MediaQuery.of(context).size.width * 0.10),
                    topRight: Radius.circular(
                        MediaQuery.of(context).size.width * 0.10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(0),
                      height: 150,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(20),
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 148, 147, 147),
                                    borderRadius: BorderRadius.circular(
                                        20), // Ujung yang tumpul
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Protein bos")
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              height: 70,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 121, 119, 119),
                                borderRadius: BorderRadius.circular(
                                    20), // Ujung yang tumpul
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              height: 70,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 124, 122, 122),
                                borderRadius: BorderRadius.circular(
                                    20), // Ujung yang tumpul
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20,
                          3), // Mengatur margin dari kiri, atas, kanan, bawah
                      alignment:
                          Alignment.topLeft, // Menempatkan teks di kiri atas
                      child: const Text(
                        'Judul di Atas Kotak Baru',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign:
                            TextAlign.left, // Mengatur teks menjadi rata kiri
                      ),
                    ),
                    const SizedBox(height: 0),
                    Container(
                      margin: const EdgeInsets.all(20),
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            255, 161, 155, 155), // Warna merah
                        borderRadius:
                            BorderRadius.circular(20), // Ujung yang tumpul
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan logika untuk membuka halaman untuk memindai QR code
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BarcodeScannerScreen()),
          );
        },
        backgroundColor: Colors.green,
        shape:
            const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
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
                // Tambahkan logika untuk navigasi ke halaman beranda
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                // Tambahkan logika untuk navigasi ke halaman berita
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsPage(
                            username: widget.username,
                            name: widget.name,
                          )),
                );
              },
              icon: const Icon(Icons.newspaper),
            ),
            const SizedBox(width: 50),
            IconButton(
              onPressed: () {
                // Tambahkan logika untuk navigasi ke halaman search
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchPage(
                            username: widget.username,
                            name: widget.name,
                          )),
                );
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                // Tambahkan logika untuk navigasi ke halaman profil
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(
                          username: widget.username, name: widget.name)),
                );
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import "package:tugas_project4_giziqu/Admin/KelolaArtikel.dart";
import 'package:tugas_project4_giziqu/user/AkunPage.dart';
import 'package:tugas_project4_giziqu/BarcodeScannerScreen.dart';
import 'package:tugas_project4_giziqu/user/LandingPage.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String name;
  const ProfilePage({Key? key, required this.username, required this.name})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 223),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(20),
              // margin: EdgeInsets.all(30),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/BG.jpg"),
                  fit: BoxFit.cover, // Atur sesuai kebutuhan Anda
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30, // Atur radius sesuai kebutuhan Anda
                    backgroundImage: AssetImage("assets/default.jpeg"),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                              fontFamily: "fonts/Schyler-Italic.ttf",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const Text(
                          "Selamat Datang Kembali",
                          style: TextStyle(
                            fontFamily: "fonts/Schyler-Italic.ttf",
                            fontSize: 16,
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
                margin: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Akun",
                          style: TextStyle(
                              fontFamily: "fonts/Schyler-Italic.ttf",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Jarak antara teks dan tombol
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AkunPage(
                                  username: widget.username,
                                  name: widget.name)),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Profile Saya',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => KelolaMakanan()),
                        // );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Data Saya',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const KelolaArtikel()),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.note_add_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Kebutuhan Gizi',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LandingPage(
                            username: widget.username,
                            name: widget.name,
                          )),
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
                // Tambahkan logika untuk navigasi ke halaman search
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
                            username: widget.username,
                            name: widget.name,
                          )),
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

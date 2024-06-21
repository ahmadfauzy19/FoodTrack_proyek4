// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import "package:tugas_project4_giziqu/Admin/KelolaArtikel.dart";
import 'package:tugas_project4_giziqu/BarcodeScannerScreen.dart';
import 'package:tugas_project4_giziqu/NewsPage.dart';
import 'package:tugas_project4_giziqu/user/LandingPage.dart';
import 'package:tugas_project4_giziqu/user/ProfilePage.dart';
import 'package:tugas_project4_giziqu/user/UbahEmailPage.dart';
import 'package:tugas_project4_giziqu/user/UbahPasswordPage.dart';
import '../global/logout.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Test",
                          style: TextStyle(
                              fontFamily: "fonts/Schyler-Italic.ttf",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
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
                              builder: (context) => const UbahEmailPage()),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ubah Email',
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
                              builder: (context) => const UbahPasswordPage()),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ubah Password',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Logout.signOut(context);
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Logout',
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
            MaterialPageRoute(
                builder: (context) => const BarcodeScannerScreen()),
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
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                );
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NewsPage()));
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
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
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

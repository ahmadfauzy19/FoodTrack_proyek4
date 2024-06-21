// ignore_for_file: unnecessary_null_comparison, file_names, unused_element, avoid_print

// import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/NewsPage.dart';
import 'package:tugas_project4_giziqu/ProfileImage/ProfilImageBuilder.dart';
import 'package:tugas_project4_giziqu/SearchPage.dart';
import 'package:tugas_project4_giziqu/user/AkunPage.dart';
import 'package:tugas_project4_giziqu/BarcodeScannerScreen.dart';
import 'package:tugas_project4_giziqu/user/DataSayaPage.dart';
import 'package:tugas_project4_giziqu/user/KebutuhanGiziPage.dart';
import 'package:tugas_project4_giziqu/user/LandingPage.dart';
import '../global/DataUser.dart';
import '../global/GetDataUser.dart';
import '../global/LoadingProgress.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser;
  String? userEmail;
  Future<DataUser?>? futureDataUser;
  late String imageUrl = '';
  UserService userService = UserService();

  void _showDialog(String message, {bool isAdmin = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informasi'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    userEmail = currentUser?.email;
    if (userEmail != null) {
      futureDataUser = userService.getDataUser(userEmail!);
      futureDataUser!.then((DataUser? dataUser) {
        imageUrl = dataUser!.foto;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 223),
      body: FutureBuilder<DataUser?>(
        future: futureDataUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingDialog(pesan: "Loading."));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found'));
          } else {
            DataUser dataUser = snapshot.data!;
            return Center(
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
                        ProfileImageBuilder(
                            username: dataUser.username, imageUrl: imageUrl),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dataUser.name,
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
                          const SizedBox(
                              height: 10), // Jarak antara teks dan tombol
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AkunPage()));
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DataSayaPage()),
                              );
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
                                    builder: (context) =>
                                        const KebutuhanGiziPage()),
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
            );
          }
        },
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
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

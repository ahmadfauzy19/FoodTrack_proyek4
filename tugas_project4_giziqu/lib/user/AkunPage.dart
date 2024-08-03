// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import "package:tugas_project4_giziqu/Admin/KelolaArtikel.dart";
import 'package:tugas_project4_giziqu/ProfileImage/ProfilImageBuilder.dart';
import 'package:tugas_project4_giziqu/global/LoadingProgress.dart';
import 'package:tugas_project4_giziqu/global/bottom_app_bar/bottom_app_bar_widget.dart';
import 'package:tugas_project4_giziqu/global/bottom_app_bar/floating_action_button_widget.dart';
import 'package:tugas_project4_giziqu/model/DataUser.dart';
import 'package:tugas_project4_giziqu/services/GetDataUser.dart';
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
  User? currentUser;
  String? userEmail;
  Future<DataUser?>? futureDataUser;
  late String imageUrl = '';
  UserService userService = UserService();

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
                            username: dataUser.username,
                            imageUrl: imageUrl,
                            activateTap: true,
                          ),
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
                                      builder: (context) =>
                                          const UbahEmailPage()),
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
                                      builder: (context) =>
                                          const UbahPasswordPage()),
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
              );
            }
          }),
      floatingActionButton: const FloatingActionButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}

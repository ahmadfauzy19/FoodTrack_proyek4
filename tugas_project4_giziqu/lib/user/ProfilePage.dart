import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_project4_giziqu/Admin/AdminPage.dart';
import 'package:tugas_project4_giziqu/global/link.dart';
import 'package:tugas_project4_giziqu/global/uploadImage.dart';
import 'package:tugas_project4_giziqu/user/AkunPage.dart';
import 'package:tugas_project4_giziqu/BarcodeScannerScreen.dart';
import 'package:tugas_project4_giziqu/user/DataSayaPage.dart';
import 'package:tugas_project4_giziqu/user/KebutuhanGiziPage.dart';
import 'package:tugas_project4_giziqu/user/LandingPage.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DataUser {
  final String name;
  final String email;
  final String role;
  final String username;
  final String foto;

  DataUser(
      {required this.name,
      required this.email,
      required this.role,
      required this.username,
      required this.foto});

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      username: json['username'],
      foto: json['foto'],
    );
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, role: $role, username: $username, foto: $foto}';
  }
}

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
  bool _isLoading = false;
  late String imageUrl = '';

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

  Future<DataUser?> getDataUser(String email) async {
    // Deklarasi variabel response di luar blok try untuk bisa digunakan di blok catch
    var response;

    final Uri uri = Uri.parse('${link}api/getDataUser');
    print(email);

    setState(() {
      _isLoading = true;
    });

    try {
      if (email == '') {
        _showDialog('email kosong'); 
        return null;
      } else {
        response = await http.post(
          uri,
          body: {
            'email': email,
          },
        );
      }

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final dataUser = DataUser.fromJson(responseData['user']);
        setState(() {
          _isLoading = false;
        });
        return dataUser;
      } else {
        setState(() {
          _isLoading = false;
        });
        _showDialog('Login gagal: ${response.body}');
        return null;
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showDialog('Kesalahan saat melakukan login: $error');
      return null;
    }
  }

  Future<String> getImageDownloadUrl(String imageName) async {
    try {
      final downloadUrl = await firebase_storage.FirebaseStorage.instance
          .ref('Images/Users/$imageName')
          .getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting download URL: $e');
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    userEmail = currentUser?.email;
    if (userEmail != null) {
      futureDataUser = getDataUser(userEmail!);
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
            return const Center(child: CircularProgressIndicator());
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
                        buildProfileImage(context, dataUser),
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
                                      builder: (context) => AkunPage()));
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
                                    builder: (context) => DataSayaPage()),
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
                                    builder: (context) => KebutuhanGiziPage()),
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
                  MaterialPageRoute(builder: (context) => LandingPage()),
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
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileImage(BuildContext context, DataUser dataUser) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            // ignore: no_leading_underscores_for_local_identifiers
            XFile? _image = await UploadImage.getImage(context);
            if (_image != null) {
              setState(() {
                _isLoading =
                    true; // Set loading menjadi true saat mulai mengunggah
              });
              // ignore: use_build_context_synchronously
              String? message = await UploadImage.uploadImage(
                  context, _image, dataUser.username);
              if (message != null) {
                setState(() {
                  imageUrl = _image.path.split('/').last;
                });
              }
              setState(() {
                _isLoading = false;
              });
            }
          },
          child: FutureBuilder<String>(
            future: getImageDownloadUrl(dataUser.foto),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (_isLoading) {
                return const CircularProgressIndicator(); // Tampilkan loading jika sedang mengunggah
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return AvatarWithCustomBorder(imageUrl: snapshot.data!);
              } else {
                return const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/default.jpeg"),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

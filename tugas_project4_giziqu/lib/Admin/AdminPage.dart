// ignore_for_file: unnecessary_null_comparison, unnecessary_cast, unused_field

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:tugas_project4_giziqu/LoginPage.dart';
import '../global/uploadImage.dart';
import '../global/logout.dart';
import '../Admin/KelolaArtikel.dart';
import '../Admin/TambahMakanan.dart';
import '../Admin/KelolaMakanan.dart';

class AdminPage extends StatefulWidget {
  final DataUser adminData;
  const AdminPage({Key? key, required this.adminData}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  XFile? _image;
  late User? currentUser;
  late String imageUrl = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    imageUrl = widget.adminData.foto;
  }

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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/BG.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: [
                  buildProfileImage(context),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          semanticsLabel: "hai",
                          currentUser != null
                              ? currentUser!.displayName ?? "Guest"
                              : "Guest",
                          style: const TextStyle(
                            fontFamily: "fonts/Schyler-Italic.ttf",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                  const Text(
                    "Kelola",
                    style: TextStyle(
                      fontFamily: "fonts/Schyler-Italic.ttf",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildMenuButton(
                    icon: Icons.add_circle_outline,
                    text: 'Tambah Makanan',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TambahMakanan()),
                      );
                    },
                  ),
                  buildMenuButton(
                    icon: Icons.food_bank_outlined,
                    text: 'Kelola Makanan',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KelolaMakanan()),
                      );
                    },
                  ),
                  buildMenuButton(
                    icon: Icons.add_circle_outline,
                    text: 'Tambah Artikel',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KelolaMakanan()),
                      );
                    },
                  ),
                  buildMenuButton(
                    icon: Icons.article_outlined,
                    text: 'Kelola Artikel',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KelolaArtikel()),
                      );
                    },
                  ),
                  buildMenuButton(
                    icon: Icons.logout,
                    text: 'Keluar',
                    onPressed: () {
                      Logout.signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileImage(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            // ignore: no_leading_underscores_for_local_identifiers
            XFile? _image = await UploadImage.getImage(context);
            if (_image != null) {
              setState(() {
                isLoading =
                    true; // Set loading menjadi true saat mulai mengunggah
              });
              // ignore: use_build_context_synchronously
              String? message = await UploadImage.uploadImage(
                  context, _image, widget.adminData.username as String);
              if (message != null) {
                setState(() {
                  imageUrl = _image.path.split('/').last;
                });
              }
              setState(() {
                isLoading = false;
              });
            }
          },
          child: FutureBuilder<String>(
            future: getImageDownloadUrl(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (isLoading) {
                return const CircularProgressIndicator(); // Tampilkan loading jika sedang mengunggah
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(snapshot.data!),
                );
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

  Widget buildMenuButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }

  Future<String> getImageDownloadUrl() async {
    try {
      print("image bos = $imageUrl");
      final downloadUrl = await firebase_storage.FirebaseStorage.instance
          .ref('Images/Users/$imageUrl')
          .getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting download URL: $e');
      rethrow;
    }
  }
}

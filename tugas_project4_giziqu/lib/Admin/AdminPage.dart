// ignore_for_file: unnecessary_null_comparison, unnecessary_cast, unused_field, avoid_print, file_names
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tugas_project4_giziqu/Admin/TambahArtikel.dart';
import '../global/logout.dart';
import '../Admin/KelolaArtikel.dart';
import '../Admin/TambahMakanan.dart';
import '../Admin/KelolaMakanan.dart';
import '../model/DataUser.dart';
import '../ProfileImage/ProfilImageBuilder.dart';

class AdminPage extends StatefulWidget {
  final DataUser adminData;
  const AdminPage({Key? key, required this.adminData}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late User? currentUser;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
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
                  ProfileImageBuilder(
                    username: widget.adminData.username,
                    imageUrl: widget.adminData.foto,
                    activateTap: true,
                  ),
                  // buildProfileImage(context),
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
                          "Selamat Datang Kembaliii",
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
                            builder: (context) => const TambahArtikel()),
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
}

class AvatarWithCustomBorder extends StatelessWidget {
  final String imageUrl;

  const AvatarWithCustomBorder({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(70, 70),
          painter: CircleBorderPainter(),
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ],
    );
  }
}

class CircleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;

    // Draw top right border (blue)
    paint.color = Colors.blueAccent;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      pi / 4, // Start angle
      pi / 2, // Sweep angle
      false,
      paint,
    );

    // Draw top right border (blue)
    paint.color = Colors.blueAccent;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -3 * pi / 4, // Start angle
      pi / 2, // Sweep angle
      false,
      paint,
    );

    // Draw bottom left border (orange)
    paint.color = Colors.orange;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      3 * pi / 4, // Start angle
      pi / 2, // Sweep angle
      false,
      paint,
    );

    paint.color = Colors.orange;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -pi / 4, // Start angle
      pi / 2, // Sweep angle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

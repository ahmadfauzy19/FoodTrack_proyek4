import 'package:flutter/material.dart';
import "package:tugas_project4_giziqu/Admin/KelolaArtikel.dart";
import "TambahMakanan.dart";
import "KelolaMakanan.dart";
import "../user/Scanresult.dart";

class AdminPage extends StatefulWidget {
  const AdminPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
                          semanticsLabel: "hai",
                          "test",
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
                          "Kelola",
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
                              builder: (context) => const TambahMakanan()),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Tambah Makanan',
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
                              builder: (context) => const KelolaMakanan()),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.food_bank_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Kelola Makanan',
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
                              builder: (context) => const KelolaMakanan()),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Tambah Artikel',
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
                            Icons.article_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Kelola Artikel',
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
    );
  }
}

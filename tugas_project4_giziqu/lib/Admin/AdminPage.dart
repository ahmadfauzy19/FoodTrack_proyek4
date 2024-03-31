import 'package:flutter/material.dart';
import "TambahMakanan.dart";

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<StatefulWidget> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 230, 223),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.all(20),
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
                    margin: EdgeInsets.all(20),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hai Admin,",
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
                margin: EdgeInsets.all(30),
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
                    SizedBox(height: 10), // Jarak antara teks dan tombol
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TambahMakanan()),
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
                        // Tindakan yang akan dilakukan saat tombol ditekan
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
                        // Tindakan yang akan dilakukan saat tombol ditekan
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

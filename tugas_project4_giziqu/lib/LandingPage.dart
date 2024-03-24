import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 230, 223),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(40),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50, // Atur radius sesuai kebutuhan Anda
                    backgroundImage: AssetImage("assets/profile_picture.jpg"),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text("Selamat Datang,"),
                        Text("Nama"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(labelText: "Search"),
                  )),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Tambahkan logika untuk melakukan pencarian di sini
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(20),
                  height: 70,
                  color: Colors.white,
                )),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(20),
                  height: 70,
                  color: Colors.white,
                )),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(20),
                  height: 70,
                  color: Colors.white,
                ))
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                onPressed: () {
                  // Tambahkan logika untuk navigasi ke halaman beranda
                },
                icon: Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {
                  // Tambahkan logika untuk navigasi ke halaman berita
                },
                icon: Icon(Icons.newspaper),
              ),
              IconButton(
                onPressed: () {
                  // Tambahkan logika untuk navigasi ke halaman favorit
                },
                icon: Icon(Icons.favorite),
              ),
              IconButton(
                onPressed: () {
                  // Tambahkan logika untuk navigasi ke halaman profil
                },
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

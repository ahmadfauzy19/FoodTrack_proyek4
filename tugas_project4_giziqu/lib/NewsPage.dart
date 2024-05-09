import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/user/LandingPage.dart';
import 'SearchPage.dart'; // Pastikan file search_page.dart diimpor dengan benar

class NewsPage extends StatelessWidget {
  const NewsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Berita"),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Paling Populer",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: PageView(
                  children: [
                    _buildNewsCard(
                      context,
                      image: "assets/gambar1.png",
                      title:
                          "banjir dikabupaten padalarang disebabkan oleh badai salju yang berada di inggris kecamatan nagreg darusasalam",
                    ),
                    _buildNewsCard(
                      context,
                      image: "assets/gambar2.png",
                      title: "Judul Berita Utama 2",
                    ),
                    _buildNewsCard(
                      context,
                      image: "assets/gambar3.png",
                      title: "Judul Berita Utama 3",
                    ),
                    // Tambahkan berita utama lainnya sesuai kebutuhan
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Terkini",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (int i = 0; i < 5; i++)
                Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/gambar1.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Judul Berita Terkini",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Isi Berita Terkini",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.white, width: 2),
        ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                // Tambahkan logika untuk navigasi ke halaman profil
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context,
      {required String image, required String title}) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

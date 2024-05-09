import 'package:flutter/material.dart';
import '../BarcodeScannerScreen.dart';
import 'ProfilePage.dart';
import '../NewsPage.dart';
import '../SearchPage.dart';

class Scanresult extends StatelessWidget {
  const Scanresult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Produk 1',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Informasi Nilai Gizi',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 400,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: ListView.builder(
                            itemCount: 12,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: const Text('Test'),
                                onTap: () {
                                  // Aksi ketika item diklik
                                  print('Tapped on ');
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Ringkasan Gizi",
                        style: TextStyle(
                          fontSize: 22,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          width: 165,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Energi",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("5 Gram")
                            ],
                          ),
                        ),
                        Container(
                          width: 165,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Protein",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("100 gram")
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    const Text("Produk Terkait",
                        style: TextStyle(
                          fontSize: 22,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 165,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 500,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 220, 217, 217),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: const Icon(Icons.photo,
                                      color: Colors.white),
                                ),
                              ),
                              // Judul
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    'Produk Lain',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 165,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 500,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 220, 217, 217),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: const Icon(Icons.photo,
                                      color: Colors.white),
                                ),
                              ),
                              // Judul
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    'Produk Lain',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scanresult()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Bandingkan'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
              onPressed: () {},
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage()),
                );
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}

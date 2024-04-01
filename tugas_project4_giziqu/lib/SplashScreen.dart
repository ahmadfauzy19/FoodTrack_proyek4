import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/InformationPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => InformationPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Gizi',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.green,
                            ),
                          ),
                          TextSpan(
                            text: 'Qu',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text("Keep Happy And Healthy")
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/gambar5.png", // Gambar di bawah layar
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/gambar4.png", // Gambar di atas layar
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/SplashScreen.dart';
import 'package:tugas_project4_giziqu/user/LandingPage.dart';

class GiziQuApp extends StatefulWidget {
  const GiziQuApp({super.key});

  @override
  State<GiziQuApp> createState() => _GiziQuAppState();
}

class _GiziQuAppState extends State<GiziQuApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const SplashScreen(),
        '/landingpage': (BuildContext context) => const LandingPage(),
      },
    );
  }
}

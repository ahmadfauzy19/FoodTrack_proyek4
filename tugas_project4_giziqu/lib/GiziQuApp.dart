import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/Admin/AdminPage.dart';
import 'package:tugas_project4_giziqu/LoginPage.dart';
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
      initialRoute: '/start',
      routes: {
        '/start': (BuildContext context) => const SplashScreen(),
        '/login': (BuildContext context) => const LoginPage(),
        '/landingpage': (BuildContext context) => const LandingPage(),
        // '/adminpage': (BuildContext context) => const AdminPage(),
      },
    );
  }
}

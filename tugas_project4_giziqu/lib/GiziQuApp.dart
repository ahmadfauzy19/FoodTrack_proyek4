import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'InformationPage.dart';

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
        '/login': (BuildContext context) => const InformationPage(),
      },
    );
  }
}

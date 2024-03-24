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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 255, 0),
      ),
      backgroundColor: Color.fromARGB(255, 255, 221, 119),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

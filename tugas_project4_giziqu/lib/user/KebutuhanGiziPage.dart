import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/global/link.dart';
import 'package:http/http.dart' as http;

class KebutuhanGiziPage extends StatefulWidget {
  const KebutuhanGiziPage({Key? key}) : super(key: key);

  @override
  State<KebutuhanGiziPage> createState() => _KebutuhanGiziPageState();
}

class _KebutuhanGiziPageState extends State<KebutuhanGiziPage> {
  User? currentUser;
  String? userEmail;

  String kalori = '';
  String karbohidrat = '';
  String lemak = '';
  String protein = '';

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    userEmail = currentUser?.email;
    print('User email: $userEmail');
    _fetchGiziUser(
        userEmail!); // Panggil fungsi untuk mendapatkan data pengguna saat initState dipanggil
  }

  Future<void> _fetchGiziUser(String email) async {
    final Uri uri =
        Uri.parse("${link}api/read_kebutuhan_gizi_by_email?email=$email");

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        print(userData);

        setState(() {
          // Set nilai default pada TextField
          kalori = userData['kalori'].toString();
          karbohidrat = userData['karbohidrat'].toString();
          lemak = userData['lemak'].toString();
          protein = userData['protein'].toString();
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kebutuhan Energi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(20),
              // margin: EdgeInsets.all(30),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("gambar6.png"),
                  fit: BoxFit.cover, // Atur sesuai kebutuhan Anda
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text("Kebutuhan Kalori Per hari:"),
            Text("$kalori kcal"),
            Text("Kebutuhan Protein Per hari:"),
            Text("$protein gram"),
            Text("Kebutuhan Lemak Per hari:"),
            Text("$lemak gram"),
            Text("Kebutuhan Karbohidrat Per hari:"),
            Text("$karbohidrat gram"),
          ],
        ),
      ),
    );
  }
}

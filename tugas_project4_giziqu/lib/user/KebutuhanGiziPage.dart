// ignore_for_file: avoid_print, file_names, avoid_unnecessary_containers, unnecessary_const

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/global/link.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tugas_project4_giziqu/user/rekomendasiMakanan.dart';

class KebutuhanGiziPage extends StatefulWidget {
  const KebutuhanGiziPage({Key? key}) : super(key: key);

  @override
  State<KebutuhanGiziPage> createState() => _KebutuhanGiziPageState();
}

class _KebutuhanGiziPageState extends State<KebutuhanGiziPage> {
  User? currentUser;
  String? userEmail;

  bool isLoading = true;
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
    if (userEmail != null) {
      _fetchGiziUser(userEmail!);
    }
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
          kalori = userData['kalori'].toString();
          karbohidrat = userData['karbohidrat'].toString();
          lemak = userData['lemak'].toString();
          protein = userData['protein'].toString();
          isLoading = false;
        });
      } else {
        print('Error: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kebutuhan Energi"),
      ),
      body: isLoading
          ? const Center(
              child: const CircularProgressIndicator(
              color: Colors.orange,
            ))
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 1.0), // Jarak dari atas layar
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/gambar6.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              double radius = constraints.maxWidth / 4 - 20;
                              return Row(
                                children: [
                                  Expanded(
                                    child: CircularPercentIndicator(
                                      radius: radius,
                                      percent: 1.0,
                                      header: const Text("Kalori"),
                                      center: Text("$kalori kcal"),
                                      progressColor: Colors.green,
                                    ),
                                  ),
                                  Expanded(
                                    child: CircularPercentIndicator(
                                      radius: radius,
                                      percent: 1.0,
                                      header: const Text("Lemak"),
                                      center: Text("$lemak gram"),
                                      progressColor: Colors.lightBlue,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              double radius = constraints.maxWidth / 4 - 20;
                              return Row(
                                children: [
                                  Expanded(
                                    child: CircularPercentIndicator(
                                      radius: radius,
                                      percent: 1.0,
                                      header: const Text("Protein"),
                                      center: Text("$protein gram"),
                                      progressColor: Colors.yellow,
                                    ),
                                  ),
                                  Expanded(
                                    child: CircularPercentIndicator(
                                      radius: radius,
                                      percent: 1.0,
                                      header: const Text("Karbohidrat"),
                                      center: Text("$karbohidrat gram"),
                                      progressColor: Colors.red,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RekomendasiMakanan()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Colors.green, // Warna latar belakang tombol
                              onPrimary: Colors.white, // Warna teks tombol
                            ),
                            child: const Text('Rekomendasi Makanan'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

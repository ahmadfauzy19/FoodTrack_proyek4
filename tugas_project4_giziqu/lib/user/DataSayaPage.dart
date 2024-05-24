import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global/link.dart';

class DataSayaPage extends StatefulWidget {
  const DataSayaPage({Key? key}) : super(key: key);

  @override
  State<DataSayaPage> createState() => _DataSayaPageState();
}

class _DataSayaPageState extends State<DataSayaPage> {
  User? currentUser;
  String? userEmail;

  // Controllers untuk TextFields
  TextEditingController tinggiBadanController = TextEditingController();
  TextEditingController beratBadanController = TextEditingController();
  TextEditingController usiaController = TextEditingController();

  // Variabel untuk nilai default dropdown
  String dropdownValue = 'laki-laki';
  String dropdownValueAktivitas = 'Sangat jarang olahraga';

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    userEmail = currentUser?.email;
    print('User email: $userEmail');
    _fetchUserData(
        userEmail!); // Panggil fungsi untuk mendapatkan data pengguna saat initState dipanggil
  }

  Future<void> _fetchUserData(String email) async {
    final Uri uri = Uri.parse("${link}api/read_profile_by_email?email=$email");

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        // print(userData);

        // Set nilai default pada TextField
        tinggiBadanController.text = userData['tinggi_badan'].toString();
        beratBadanController.text = userData['berat_badan'].toString();
        usiaController.text = userData['usia'].toString();

        // Set nilai default pada DropdownButton
        setState(() {
          // dropdownValue = userData['jenis_kelamin'];
          dropdownValueAktivitas = userData['faktor_aktivitas'];
        });

        // Lakukan sesuatu dengan data profil pengguna yang diterima, misalnya simpan ke dalam variabel atau lakukan operasi lain
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  var jenisKelamin = [
    'laki-laki',
    'perempuan',
  ];

  var faktorAktivitas = [
    'Sangat jarang olahraga',
    'Jarang olahraga',
    'Cukup olahraga',
    'Sering olahraga',
    'Sangat sering olahraga',
  ];

  Future<String> create_update_profile_diri(
    String email,
    int tinggiBadan,
    int beratBadan,
    String jenisKelamin,
    int usia,
    String faktorAktivitas,
  ) async {
    final Uri uri = Uri.parse("${link}api/create_update_profile_diri");

    try {
      final response = await http.post(
        uri,
        body: {
          'email': email,
          'tinggi_badan': tinggiBadan.toString(),
          'berat_badan': beratBadan.toString(),
          'jenis_kelamin': jenisKelamin,
          'usia': usia.toString(),
          'faktor_aktivitas': faktorAktivitas,
        },
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Informasi'),
              content: const Text('Data berhasil disimpan.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return "berhasil";
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Informasi'),
              content: Text('Data gagal disimpan: ${response.body}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return "gagal";
      }
    } catch (error) {
      print('Kesalahan dalam menghitung : $error');
      return "gagal";
    }
  }

  void _saveProfileData() {
    String email = userEmail!;
    int tinggiBadan = int.tryParse(tinggiBadanController.text) ?? 0;
    int beratBadan = int.tryParse(beratBadanController.text) ?? 0;
    String jenisKelamin = dropdownValue;
    int usia = int.tryParse(usiaController.text) ?? 0;
    String faktorAktivitas = dropdownValueAktivitas;

    create_update_profile_diri(
      email,
      tinggiBadan,
      beratBadan,
      jenisKelamin,
      usia,
      faktorAktivitas,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lengkapi Data")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Tinggi Badan (cm)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border.all()),
                        child: TextField(
                          controller: tinggiBadanController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Masukkan tinggi badan',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Berat Badan (kg)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border.all()),
                        child: TextField(
                          controller: beratBadanController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Masukkan berat badan',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Jenis Kelamin',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all()),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: jenisKelamin.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Usia (tahun)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: usiaController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Masukkan Usia',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Faktor Aktivitas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all()),
              child: DropdownButton<String>(
                value: dropdownValueAktivitas,
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValueAktivitas = newValue!;
                  });
                },
                items: faktorAktivitas.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _saveProfileData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    "Hitung",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

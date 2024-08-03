// ignore_for_file: unnecessary_const, avoid_print, non_constant_identifier_names, file_names

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
  bool isLoading = false;

  // Controllers untuk TextFields
  final TextEditingController tinggiBadanController = TextEditingController();
  final TextEditingController beratBadanController = TextEditingController();
  final TextEditingController usiaController = TextEditingController();

  // Variabel untuk nilai default dropdown
  String dropdownValue = 'laki-laki';
  String dropdownValueAktivitas = 'Sangat jarang olahraga';

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    userEmail = currentUser?.email;
    print('User email: $userEmail');
    if (userEmail != null) {
      _fetchUserData(userEmail!);
    }
  }

  Future<void> _fetchUserData(String email) async {
    setState(() {
      isLoading = true;
    });

    final Uri uri = Uri.parse("${link}api/read_profile_by_email?email=$email");

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);

        setState(() {
          tinggiBadanController.text = userData['tinggi_badan'].toString();
          beratBadanController.text = userData['berat_badan'].toString();
          usiaController.text = userData['usia'].toString();
          dropdownValueAktivitas = userData['faktor_aktivitas'];
          isLoading = false;
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveProfileData() async {
    setState(() {
      isLoading = true;
    });

    final email = userEmail!;
    final tinggiBadan = int.tryParse(tinggiBadanController.text) ?? 0;
    final beratBadan = int.tryParse(beratBadanController.text) ?? 0;
    final jenisKelamin = dropdownValue;
    final usia = int.tryParse(usiaController.text) ?? 0;
    final faktorAktivitas = dropdownValueAktivitas;

    final status = await create_update_profile_diri(
      email,
      tinggiBadan,
      beratBadan,
      jenisKelamin,
      usia,
      faktorAktivitas,
    );

    setState(() {
      isLoading = false;
    });

    if (status == "berhasil") {
      // Refresh user data after successful save
      _fetchUserData(email);
    }
  }

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
        _showDialog('Informasi', 'Data berhasil disimpan.');
        return "berhasil";
      } else {
        _showDialog('Informasi', 'Data gagal disimpan: ${response.body}');
        return "gagal";
      }
    } catch (error) {
      print('Kesalahan dalam menghitung: $error');
      _showDialog('Informasi', 'Terjadi kesalahan: $error');
      return "gagal";
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lengkapi Data")),
      body: isLoading
          ? const Center(
              child: const CircularProgressIndicator(
              color: Colors.orange,
            ))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: _buildTextField(
                          controller: tinggiBadanController,
                          label: 'Tinggi Badan (cm)',
                          hintText: 'Masukkan tinggi badan',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        flex: 1,
                        child: _buildTextField(
                          controller: beratBadanController,
                          label: 'Berat Badan (kg)',
                          hintText: 'Masukkan berat badan',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDropdown(
                    label: 'Jenis Kelamin',
                    value: dropdownValue,
                    items: jenisKelamin,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: usiaController,
                    label: 'Usia (tahun)',
                    hintText: 'Masukkan Usia',
                  ),
                  const SizedBox(height: 20),
                  _buildDropdown(
                    label: 'Faktor Aktivitas',
                    value: dropdownValueAktivitas,
                    items: faktorAktivitas,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueAktivitas = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _saveProfileData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          "Hitung",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Implement reset logic if needed
                        },
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all()),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all()),
          child: DropdownButton<String>(
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 24,
            elevation: 16,
            isExpanded: true,
            onChanged: onChanged,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ],
    );
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
}

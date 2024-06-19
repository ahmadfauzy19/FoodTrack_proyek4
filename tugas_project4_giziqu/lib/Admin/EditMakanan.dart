// ignore_for_file: avoid_print, file_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global/link.dart';

class EditMakanan extends StatefulWidget {
  final String barcode;
  const EditMakanan({Key? key, required this.barcode}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditMakananState createState() => _EditMakananState();
}

class _EditMakananState extends State<EditMakanan> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _kaloriController;
  late TextEditingController _karbohidratController;
  late TextEditingController _lemakController;
  late TextEditingController _natriumController;
  late TextEditingController _proteinController;
  late TextEditingController _seratController;
  late TextEditingController _vitaminAController;
  late TextEditingController _vitaminB1Controller;
  late TextEditingController _vitaminB2Controller;
  late TextEditingController _vitaminB3Controller;
  late TextEditingController _vitaminCController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _typeController = TextEditingController();
    _kaloriController = TextEditingController();
    _karbohidratController = TextEditingController();
    _lemakController = TextEditingController();
    _natriumController = TextEditingController();
    _proteinController = TextEditingController();
    _seratController = TextEditingController();
    _vitaminAController = TextEditingController();
    _vitaminB1Controller = TextEditingController();
    _vitaminB2Controller = TextEditingController();
    _vitaminB3Controller = TextEditingController();
    _vitaminCController = TextEditingController();
    _fetchMakananDetails();
  }

  Future<void> _fetchMakananDetails() async {
    print("barcode = ${widget.barcode}");
    final Uri uri = Uri.parse(
        "${link}api/makanan/search_makanan_barcode?keyword=${widget.barcode}");

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null && jsonResponse['data'].isNotEmpty) {
          var data = jsonResponse['data'][0];

          setState(() {
            _nameController.text = data['nama_makanan'] ?? '';
            _typeController.text = data['jenis'] ?? '';

            var gizi = data['gizi'] ?? {};
            _kaloriController.text = (gizi['kalori'] ?? '').toString();
            _karbohidratController.text =
                (gizi['karbohidrat'] ?? '').toString();
            _lemakController.text = (gizi['lemak'] ?? '').toString();
            _natriumController.text = (gizi['natrium'] ?? '').toString();
            _proteinController.text = (gizi['protein'] ?? '').toString();
            _seratController.text = (gizi['serat'] ?? '').toString();
            _vitaminAController.text = (gizi['vitamin_a'] ?? '').toString();
            _vitaminB1Controller.text = (gizi['vitamin_b1'] ?? '').toString();
            _vitaminB2Controller.text = (gizi['vitamin_b2'] ?? '').toString();
            _vitaminB3Controller.text = (gizi['vitamin_b3'] ?? '').toString();
            _vitaminCController.text = (gizi['vitamin_c'] ?? '').toString();
          });
        } else {
          print('Error: No data found');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> _updateMakanan() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final Uri uri =
            Uri.parse("${link}api/makanan/update_makanan/${widget.barcode}");
        var response = await http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'barcode': widget.barcode,
            'nama_makanan': _nameController.text,
            'jenis': _typeController.text,
            'gizi': {
              'kalori': _kaloriController.text,
              'karbohidrat': _karbohidratController.text,
              'lemak': _lemakController.text,
              'natrium': _natriumController.text,
              'protein': _proteinController.text,
              'serat': _seratController.text,
              'vitamin_a': _vitaminAController.text,
              'vitamin_b1': _vitaminB1Controller.text,
              'vitamin_b2': _vitaminB2Controller.text,
              'vitamin_b3': _vitaminB3Controller.text,
              'vitamin_c': _vitaminCController.text,
            },
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Makanan berhasil diperbarui')),
          );
          Navigator.of(context).pop();
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _kaloriController.dispose();
    _karbohidratController.dispose();
    _lemakController.dispose();
    _natriumController.dispose();
    _proteinController.dispose();
    _seratController.dispose();
    _vitaminAController.dispose();
    _vitaminB1Controller.dispose();
    _vitaminB2Controller.dispose();
    _vitaminB3Controller.dispose();
    _vitaminCController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Makanan'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration:
                          const InputDecoration(labelText: 'Nama Makanan'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Makanan tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _typeController,
                      decoration:
                          const InputDecoration(labelText: 'Jenis Makanan'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jenis Makanan tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _kaloriController,
                      decoration: const InputDecoration(labelText: 'Kalori'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kalori tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _karbohidratController,
                      decoration:
                          const InputDecoration(labelText: 'Karbohidrat'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Karbohidrat tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lemakController,
                      decoration: const InputDecoration(labelText: 'Lemak'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lemak tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _natriumController,
                      decoration: const InputDecoration(labelText: 'Natrium'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Natrium tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _proteinController,
                      decoration: const InputDecoration(labelText: 'Protein'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Protein tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _seratController,
                      decoration: const InputDecoration(labelText: 'Serat'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Serat tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _vitaminAController,
                      decoration: const InputDecoration(labelText: 'Vitamin A'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vitamin A tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _vitaminB1Controller,
                      decoration:
                          const InputDecoration(labelText: 'Vitamin B1'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vitamin B1 tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _vitaminB2Controller,
                      decoration:
                          const InputDecoration(labelText: 'Vitamin B2'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vitamin B2 tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _vitaminB3Controller,
                      decoration:
                          const InputDecoration(labelText: 'Vitamin B3'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vitamin B3 tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _vitaminCController,
                      decoration: const InputDecoration(labelText: 'Vitamin C'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vitamin C tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateMakanan,
                      child: const Text('Update Makanan'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

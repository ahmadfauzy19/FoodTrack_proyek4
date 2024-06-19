// ignore_for_file: avoid_print, file_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global/link.dart';

class EditArtikel extends StatefulWidget {
  final String id;
  const EditArtikel({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditArtikelState createState() => _EditArtikelState();
}

class _EditArtikelState extends State<EditArtikel> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaArtikelController;
  late TextEditingController _linkController;
  late TextEditingController _deskripsiController;
  late TextEditingController _jenisController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _namaArtikelController = TextEditingController();
    _linkController = TextEditingController();
    _deskripsiController = TextEditingController();
    _jenisController = TextEditingController();
    _fetchArtikelDetails();
  }

  Future<void> _fetchArtikelDetails() async {
    print("ID = ${widget.id}");
    final Uri uri =
        Uri.parse("${link}api/search_artikel_id?keyword=${widget.id}");

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null && jsonResponse['data'].isNotEmpty) {
          var data = jsonResponse['data'][0];

          setState(() {
            _namaArtikelController.text = data['nama_artikel'] ?? '';
            _linkController.text = data['link'] ?? '';
            _deskripsiController.text = data['deskripsi'] ?? '';
            _jenisController.text = data['jenis'] ?? '';
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

  Future<void> _updateArtikel() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final Uri uri = Uri.parse("${link}api/update_artikel");
        var response = await http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'id': widget.id,
            'nama_artikel': _namaArtikelController.text,
            'link': _linkController.text,
            'deskripsi': _deskripsiController.text,
            'jenis': _jenisController.text,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Artikel berhasil diperbarui')),
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
    _namaArtikelController.dispose();
    _linkController.dispose();
    _deskripsiController.dispose();
    _jenisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Artikel'),
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
                      controller: _namaArtikelController,
                      decoration:
                          const InputDecoration(labelText: 'Nama Artikel'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Artikel tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _linkController,
                      decoration:
                          const InputDecoration(labelText: 'Link Artikel'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Link Artikel tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _deskripsiController,
                      decoration:
                          const InputDecoration(labelText: 'Deskripsi Artikel'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Deskripsi Artikel tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _jenisController,
                      decoration:
                          const InputDecoration(labelText: 'Jenis Artikel'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jenis Artikel tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateArtikel,
                      child: const Text('Update Artikel'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

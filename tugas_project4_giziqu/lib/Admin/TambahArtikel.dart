// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps, library_private_types_in_public_api, file_names

// import 'dart:convert';
// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../global/link.dart';
import '../global/uploadImage.dart';
import '../global/LoadingProgress.dart';

class TambahArtikel extends StatefulWidget {
  const TambahArtikel({Key? key}) : super(key: key);

  @override
  _TambahArtikelState createState() => _TambahArtikelState();
}

class _TambahArtikelState extends State<TambahArtikel> {
  XFile? _image;
  final TextEditingController _namaArtikelController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _jenisController = TextEditingController();
  bool sendData = false;
  bool isLoading = false;

  void _resetForm() {
    _namaArtikelController.clear();
    _linkController.clear();
    _deskripsiController.clear();
    _jenisController.clear();
    _image = null;
    sendData = false;
  }

  void _onSendDataSuccess() {
    setState(() {
      sendData = true;
      _resetForm();
    });
  }

  Future<void> sendDataToAPI(BuildContext context) async {
    final Uri uri = Uri.parse('${link}api/create_artikel_makanan');
    setState(() {
      isLoading = true;
    });

    // Show the loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: LoadingDialog(pesan: "mengirim data"));
      },
    );

    try {
      var request = http.MultipartRequest('POST', uri)
        ..fields['nama_artikel'] = _namaArtikelController.text
        ..fields['link'] = _linkController.text
        ..fields['deskripsi'] = _deskripsiController.text
        ..fields['jenis'] = _jenisController.text;

      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _image!.path));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false; // Set loading to false when done uploading
        });
        Navigator.pop(context); // Close the loading dialog
        _onSendDataSuccess();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data berhasil dikirim!'),
          ),
        );
      } else {
        Navigator.pop(context); // Close the loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Failed to upload data. Error: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading to false when an error occurs
      });
      Navigator.pop(context); // Close the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Artikel'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            color: Colors.black,
            height: 5,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nama Artikel'),
              const SizedBox(height: 5),
              TextField(
                controller: _namaArtikelController,
                decoration: InputDecoration(
                  hintText: "Nama Artikel",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Jenis Makanan'),
              const SizedBox(height: 5),
              TextField(
                controller: _jenisController,
                decoration: InputDecoration(
                  hintText: "masukan jenis makanan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 10),
              const Text("Mengupload Foto"),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 69, 68, 68)),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () async {
                        _image = await UploadImage.getImage(context);
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 187, 186, 186),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        fixedSize: const Size(105, 35),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        "Pilih File",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _linkController,
                      decoration: InputDecoration(
                        hintText: "Masukan Link",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        prefixIcon: const Icon(Icons.link),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Deskripsi'),
              const SizedBox(height: 5),
              TextField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  hintText: "Deskripsi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                maxLines: 4,
              ),
              // SizedBox(height: max(350, 10)),
              const SizedBox(
                height: 140,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () async {
                        print(_linkController.text);
                        if (_namaArtikelController.text.isEmpty ||
                            _linkController.text.isEmpty ||
                            _image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Harap lengkapi semua field.'),
                            ),
                          );
                          return;
                        }

                        await sendDataToAPI(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

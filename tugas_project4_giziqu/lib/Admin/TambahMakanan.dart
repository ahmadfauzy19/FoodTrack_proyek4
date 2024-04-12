import 'dart:math';
import 'package:flutter/material.dart';
import 'TambahGizi.dart';

class TambahMakanan extends StatefulWidget {
  const TambahMakanan({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TambahMakananState createState() => _TambahMakananState();
}

class _TambahMakananState extends State<TambahMakanan> {
  String? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Produk'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            color: Colors.black,
            height: 5,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Produk'),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  hintText: "Nama Produk",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              SizedBox(height: 0.5),
              Row(
                children: [
                  Radio(
                    value: 'Makanan',
                    groupValue: _selectedChoice,
                    onChanged: (value) {
                      setState(() {
                        _selectedChoice = value as String?;
                      });
                    },
                  ),
                  Text('Makanan'),
                  SizedBox(width: 20),
                  Radio(
                    value: 'Minuman',
                    groupValue: _selectedChoice,
                    onChanged: (value) {
                      setState(() {
                        _selectedChoice = value as String?;
                      });
                    },
                  ),
                  Text('Minuman'),
                ],
              ),
              SizedBox(height: 10),
              Text("Menguploud Foto"),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 69, 68, 68)),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Pilih File",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 187, 186, 186),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fixedSize: Size(105, 35),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "No Barcode",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        prefixIcon: Icon(Icons.qr_code_scanner_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: max(300, 0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TambahGizi()),
                        );
                      },
                      child: Text(
                        "Lanjutkan",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
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

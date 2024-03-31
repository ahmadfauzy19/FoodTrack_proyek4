import 'package:flutter/material.dart';

class TambahMakanan extends StatefulWidget {
  const TambahMakanan({super.key});

  @override
  State<StatefulWidget> createState() => _TambahMakananState();
}

class _TambahMakananState extends State<TambahMakanan> {
  String? _selectedChoice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Makanan'),
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
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Nama Makanan'),
                ],
              ),
              SizedBox(height: 5), // Jarak antara judul dan teksfield
              TextField(
                decoration: InputDecoration(
                    hintText: "Nama Makanan",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0),
                      borderRadius: BorderRadius.circular(
                          50), // Mengatur radius border menjadi 50
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
              ),
              SizedBox(height: 0.5), // Jarak antara TextField dan pilihan
              Row(
                children: [
                  Radio(
                    value: 'Makanan',
                    groupValue: _selectedChoice,
                    onChanged: (value) {
                      setState(() {
                        _selectedChoice = value;
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
                        _selectedChoice = value;
                      });
                    },
                  ),
                  Text('Minuman'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

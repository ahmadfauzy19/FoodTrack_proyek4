import 'dart:math';
import 'package:flutter/material.dart';

class TambahGizi extends StatefulWidget {
  const TambahGizi({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TambahGiziState createState() => _TambahGiziState();
}

class _TambahGiziState extends State<TambahGizi> {
  String? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Gizi'),
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
        child: Text("Tambah Gizi"),
      ),
    );
  }
}

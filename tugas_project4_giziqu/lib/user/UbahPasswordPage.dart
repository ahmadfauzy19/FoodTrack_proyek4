import 'package:flutter/material.dart';

class UbahPasswordPage extends StatelessWidget {
  const UbahPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah Password"),
      ),
      body: Center(
        child: Column(
          children: [
            EmailChangeForm(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Konfirmasi'),
                      content:
                          Text('Apakah Anda yakin ingin mengubah password?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); //
                          },
                          child: Text('Ubah'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Ubah",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "Batal",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget EmailChangeForm() {
  String password = '';
  String password_lama = "";
  String validasi = "";
  return Container(
    margin: EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Masukkan Password Yang Lama"),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color.fromARGB(26, 145, 142, 142),
          ),
          child: TextField(
            onChanged: (value) {
              password_lama = value;
            },
          ),
        ),
        Text("Masukkan Password Yang Baru"),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color.fromARGB(26, 145, 142, 142),
          ),
          child: TextField(
            onChanged: (value) {
              password = value;
            },
          ),
        ),
        Text("Validasi Password Yang Baru"),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color.fromARGB(26, 145, 142, 142),
          ),
          child: TextField(
            onChanged: (value) {
              validasi = value;
            },
          ),
        ),
      ],
    ),
  );
}

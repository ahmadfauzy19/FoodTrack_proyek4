import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String _barcodeScanRes =
      ''; // Variabel untuk menyimpan hasil pemindaian barcode
  bool _isScanning =
      false; // Menandakan apakah pemindaian barcode sedang berlangsung

  // Method untuk memulai pemindaian barcode
  Future<void> _startBarcodeScan() async {
    setState(() {
      _isScanning =
          true; // Setel _isScanning menjadi true saat pemindaian dimulai
    });

    // Tampilkan dialog dengan tombol tambahan
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tombol Tambahan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tekan tombol tambahan untuk melakukan sesuatu."),
              SizedBox(height: 20),
              if (_isScanning)
                CircularProgressIndicator(), // Tampilkan indicator loading selama pemindaian sedang berlangsung
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Logika saat tombol tambahan ditekan
                Navigator.pop(context);
              },
              child: Text("Tombol"),
            ),
          ],
        );
      },
    );

    try {
      // Mulai pemindaian barcode
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Batal',
        true,
        ScanMode.BARCODE,
      );

      setState(() {
        _barcodeScanRes = barcodeScanRes; // Simpan hasil pemindaian barcode
        _isScanning =
            false; // Setel _isScanning menjadi false setelah pemindaian selesai
      });
    } on PlatformException {
      setState(() {
        _barcodeScanRes = 'Failed to scan barcode.';
        _isScanning =
            false; // Setel _isScanning menjadi false dalam kasus pemindaian gagal
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Column(
                children: [
                  Text(
                    'Hasil Pemindaian Barcode:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _barcodeScanRes,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Pengingat"),
                  Text(
                      "Pastikan Scan barcode sesuai dengan posisinya dan pastikan koneksi Internet lancar"),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Scan Barcode",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Scan Barang",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // Tambahkan tombol untuk memulai pemindaian barcode
      floatingActionButton: FloatingActionButton(
        onPressed: _startBarcodeScan,
        backgroundColor: Colors.green,
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
        child: Icon(
          Icons.qr_code_scanner_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//  _startBarcodeScan,
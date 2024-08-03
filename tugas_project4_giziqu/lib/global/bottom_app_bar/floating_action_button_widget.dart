import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/BarcodeScannerScreen.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
        );
      },
      backgroundColor: Colors.green,
      shape:
          const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
      child: const Icon(
        Icons.qr_code_scanner_rounded,
        color: Colors.white,
      ),
    );
  }
}

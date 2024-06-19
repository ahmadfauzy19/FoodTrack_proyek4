// ignore_for_file: unused_field, library_private_types_in_public_api, file_names

import 'dart:async';
import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  final String pesan;
  const LoadingDialog({Key? key, required this.pesan}) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  late Timer _timer;
  int _dotCount = 0;
  final bool _isReversed = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4; // Cycle through 0 to 3 dots
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    '${widget.pesan}${'.' * _dotCount}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}

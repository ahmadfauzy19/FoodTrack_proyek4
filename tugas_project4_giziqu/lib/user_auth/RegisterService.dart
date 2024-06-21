// register_service.dart
// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global/link.dart';
import '../global/LoadingProgress.dart';

class RegisterService {
  static Future<String> registerUser(
      BuildContext context,
      String name,
      String username,
      String email,
      String password,
      TabController _tabController) async {
    final Uri uri = Uri.parse("${link}api/daftar");

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoadingDialog(pesan: "Sedang mendaftar");
        },
      );
      final response = await http.post(
        uri,
        body: {
          'name': name,
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        _tabController.animateTo(0);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Informasi'),
              content: const Text('Registrasi berhasil. Silakan masuk.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return "berhasil";
      } else {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Informasi'),
              content: Text('Registrasi gagal: ${response.body}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return "gagal";
      }
    } catch (error) {
      Navigator.of(context).pop();
      print('Kesalahan saat melakukan registrasi: $error');
    }
    return "gagal";
  }
}

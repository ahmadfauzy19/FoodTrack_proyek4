// login_service.dart
// ignore_for_file: use_build_context_synchronously, unused_local_variable, no_leading_underscores_for_local_identifiers, file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/GetDataUser.dart'; // Impor UserService jika diperlukan
import '../model/DataUser.dart'; // Impor DataUser jika diperlukan
import '../global/LoadingProgress.dart'; // Impor LoadingDialog jika diperlukan
import '../Admin/AdminPage.dart';

class LoginService {
  static Future<void> signIn(
      BuildContext context,
      String email,
      String password,
      TabController _tabController,
      Function _showDialog) async {
    bool _isLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog(pesan: "Sedang login");
      },
    );
    UserService userService = UserService();
    DataUser? dataUser = await userService.getDataUser(email);

    if (dataUser != null) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: dataUser.email,
          password: password,
        );

        if (dataUser.role == "admin") {
          Navigator.of(context).pop(); // Tutup dialog loading
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPage(adminData: dataUser),
            ),
          );
        } else {
          Navigator.pushNamed(context, "/landingpage");
        }
      } catch (e) {
        _isLoading =
            false; // Atur status loading menjadi false setelah proses selesai
        Navigator.of(context).pop(); // Tutup dialog loading
        _showDialog('Kesalahan saat melakukan login: $e');
      }
    } else {
      Navigator.of(context).pop();
      _showDialog("email/password salah");
    }
  }
}

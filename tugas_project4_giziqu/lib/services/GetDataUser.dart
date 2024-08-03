// user_service.dart
// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global/link.dart';
import '../model/DataUser.dart'; // Pastikan untuk mengimpor file data_user.dart di mana DataUser didefinisikan.

class UserService {
  DataUser? dataUser; // Variabel data user sebagai properti
  Future<DataUser?> getDataUser(String email) async {
    http.Response response;
    final Uri uri = Uri.parse('${link}api/getDataUser');
    if (email == '') {
      return null;
    } else {
      response = await http.post(
        uri,
        body: {
          'email': email,
        },
      );
    }
    print('Response Bodyyy: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['user'] is Map<String, dynamic>) {
        dataUser = DataUser.fromJson(responseData['user']);
        return dataUser;
      } else {
        print('Unexpected response format: ${responseData['user']}');
        return null;
      }
    }
    return null;
  }
}

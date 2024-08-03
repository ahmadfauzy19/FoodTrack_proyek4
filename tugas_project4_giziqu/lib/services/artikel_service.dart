import 'dart:convert'; // Untuk jsonDecode
import 'package:http/http.dart' as http; // Untuk http request
import '../global/link.dart';

class ArtikelServices {
  // Fungsi untuk mengambil data dari API
  Future<List<Map<String, dynamic>>> fetchNews() async {
    final response =
        await http.get(Uri.parse('${link}api/read_semua_artikel_makanan'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Map<String, dynamic>> filteredData = responseData
          .where((data) => data != null)
          .cast<Map<String, dynamic>>()
          .toList();
      return filteredData;
    } else {
      throw Exception('Failed to load news');
    }
  }
}

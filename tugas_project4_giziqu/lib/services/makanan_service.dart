import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_project4_giziqu/global/link.dart';
import 'package:tugas_project4_giziqu/model/MakananModel.dart';

class MakananService {
  static Future<List<Makanan>> searchMakanan(String keyword) async {
    final String baseUrl = "$link"; // Ganti dengan base URL endpoint API Anda
    final String searchEndpoint = "api/makanan/search_makanan";

    final Uri uri = Uri.parse("$baseUrl$searchEndpoint?keyword=$keyword");

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<Makanan> makananList = [];
        for (var item in jsonData['data']) {
          Makanan makanan = Makanan.fromJson(item);
          makananList.add(makanan);
        }
        return makananList;
      } else {
        print('Error: ${response.statusCode}');
        return []; // Return empty list jika ada error atau data tidak ditemukan
      }
    } catch (e) {
      print('Exception: $e');
      return []; // Return empty list jika terjadi exception
    }
  }

  static Future<List<Makanan>> fetchMakananByJenis(String jenis) async {
    final String baseUrl = "$link"; // Ganti dengan base URL endpoint API Anda
    final String searchEndpoint = "api/makanan/search_makanan_by_jenis";
    final response =
        await http.get(Uri.parse('$baseUrl$searchEndpoint?jenis=$jenis'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Makanan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load makanan');
    }
  }

  static Future<List<Makanan>> scanBarcode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Batal',
        true,
        ScanMode.BARCODE,
      );

      if (barcodeScanRes == '-1') {
        return [];
      }

      final Uri uri = Uri.parse(
          "${link}api/makanan/search_makanan_barcode?keyword=$barcodeScanRes");

      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<Makanan> makananList = [];
        for (var item in jsonData['data']) {
          Makanan makanan = Makanan.fromJson(item);
          makananList.add(makanan);
        }
        return makananList;
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } on PlatformException catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  List<Map<String, dynamic>> convertMakananListToJson(List<Makanan> makanans) {
    List<Map<String, dynamic>> jsonList = [];
    makanans.forEach((makanan) {
      jsonList.add(makanan.toJson());
    });
    return jsonList;
  }
}

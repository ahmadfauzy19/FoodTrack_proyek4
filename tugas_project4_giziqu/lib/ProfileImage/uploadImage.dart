// ignore_for_file: file_names, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, avoid_print

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../global/link.dart';

class UploadImage {
  static Future<XFile?> getImage(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("Nama file yang dipilih: ${pickedFile.path.split('/').last}");
    }

    return pickedFile;
  }

  static Future<String> uploadImage(
      BuildContext context, XFile? _image, String id) async {
    if (_image == null) {
      return "";
    }

    final Uri uri = Uri.parse('${link}api/image');

    try {
      var request = http.MultipartRequest('POST', uri);
      request.fields['id'] = id; // Menambahkan id ke dalam bagian fields
      request.files
          .add(await http.MultipartFile.fromPath('image', _image.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        return "Failed to upload image. Server responded with status code: ${response.statusCode}";
      }
    } catch (e) {
      return "Error uploading image: $e";
    }
  }
}

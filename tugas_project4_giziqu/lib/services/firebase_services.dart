import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseService {
  static Future<String> getImageDownloadUrl(
      String imageUrl, String path) async {
    try {
      final downloadUrl = await firebase_storage.FirebaseStorage.instance
          .ref('$path$imageUrl')
          .getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting download URL: $e');
      throw e;
    }
  }
}

// Images/MakananImage/
// ignore_for_file: file_names, library_private_types_in_public_api, dead_code, use_build_context_synchronously, avoid_print, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'uploadImage.dart';
import 'AvatarCustomBorder.dart';

class ProfileImageBuilder extends StatefulWidget {
  final String username; // Username for image upload
  final String imageUrl;
  final bool activateTap;
  const ProfileImageBuilder(
      {Key? key,
      required this.username,
      required this.imageUrl,
      required this.activateTap})
      : super(key: key);

  @override
  _ProfileImageBuilderState createState() => _ProfileImageBuilderState();
}

class _ProfileImageBuilderState extends State<ProfileImageBuilder> {
  bool isLoading = false;
  late String imageUrl = '';

  @override
  void initState() {
    super.initState();
    imageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    bool shouldHandleTap =
        widget.activateTap; // Set this condition based on your needs

    return Stack(
      children: [
        GestureDetector(
          onTap: shouldHandleTap ? _handleImageUpload : null,
          child: FutureBuilder<String>(
            future: getImageDownloadUrl(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (isLoading) {
                return const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                );
                ;
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                );
              } else if (snapshot.hasError) {
                return Text('Error : ${snapshot.error}');
              } else if (snapshot.hasData) {
                return AvatarCustomBorder(imageUrl: snapshot.data!);
              } else {
                return const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/default.jpeg"),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> _handleImageUpload() async {
    // ignore: no_leading_underscores_for_local_identifiers
    XFile? _image = await UploadImage.getImage(context);
    if (_image != null) {
      setState(() {
        isLoading = true; // Set loading menjadi true saat mulai mengunggah
      });
      String? message =
          await UploadImage.uploadImage(context, _image, widget.username);
      if (message != null) {
        print("masuk bos uploud image");
        setState(() {
          imageUrl = _image.path.split('/').last;
        });
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String> getImageDownloadUrl() async {
    try {
      final downloadUrl = await firebase_storage.FirebaseStorage.instance
          .ref('Images/Users/$imageUrl')
          .getDownloadURL();
      print("Berhasil Download : $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print('Error getting download URL: $e');
      rethrow;
    }
  }
}

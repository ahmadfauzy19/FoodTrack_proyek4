// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, avoid_print, library_private_types_in_public_api, file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'uploadImage.dart';
import 'AvatarCustomBorder.dart';

class ProfileImageBuilder extends StatefulWidget {
  final String username; // Username for image upload
  final String imageUrl;
  const ProfileImageBuilder(
      {Key? key, required this.username, required this.imageUrl})
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
    // TODO: implement initState
    imageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            // ignore: no_leading_underscores_for_local_identifiers
            XFile? _image = await UploadImage.getImage(context);
            if (_image != null) {
              setState(() {
                isLoading =
                    true; // Set loading menjadi true saat mulai mengunggah
              });
              // ignore: use_build_context_synchronously
              String? message = await UploadImage.uploadImage(
                  context, _image, widget.username);
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
          },
          child: FutureBuilder<String>(
            future: getImageDownloadUrl(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (isLoading) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
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

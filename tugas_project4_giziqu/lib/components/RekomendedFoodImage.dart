// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/services/firebase_services.dart';

class RecommendedFoodImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const RecommendedFoodImage({
    Key? key,
    required this.imageUrl,
    this.width = 80, // Default width for recommended images
    this.height = 80, // Default height for recommended images
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future:
          FirebaseService.getImageDownloadUrl(imageUrl, "Images/MakananImage/"),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: width,
            height: height,
            child: const CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10), // Rounded corners
            child: Image.network(
              snapshot.data!,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return SizedBox(
            width: width,
            height: height,
            child: const Center(
              child: Text('No image available'),
            ),
          );
        }
      },
    );
  }
}

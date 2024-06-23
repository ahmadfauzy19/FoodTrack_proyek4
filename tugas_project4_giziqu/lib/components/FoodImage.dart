import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/services/firebase_services.dart';

class FoodImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const FoodImage({
    Key? key,
    required this.imageUrl,
    this.width = 200, // Default width
    this.height = 200, // Default height
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
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Image.network(
            snapshot.data!,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        } else {
          return SizedBox(
            width: width,
            height: height,
            child: Center(
              child: Text('No image available'),
            ),
          );
        }
      },
    );
  }
}

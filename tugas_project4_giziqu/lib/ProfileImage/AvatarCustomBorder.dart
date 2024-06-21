import 'package:flutter/material.dart';
import 'CircleBorderPainter.dart';

class AvatarCustomBorder extends StatelessWidget {
  final String imageUrl;

  const AvatarCustomBorder({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(70, 70),
          painter: CircleBorderPainter(),
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ],
    );
  }
}

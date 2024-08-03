import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  final Color color;
  final String imagePath;
  final String? text;
  final VoidCallback onTap;

  const BoxWidget({
    Key? key,
    required this.color,
    required this.imagePath,
    this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 70,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          if (text != null) const SizedBox(height: 0),
          if (text != null) Text(text!),
        ],
      ),
    );
  }
}

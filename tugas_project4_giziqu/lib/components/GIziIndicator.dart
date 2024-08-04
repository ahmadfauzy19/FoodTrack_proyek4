import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String status;

  StatusWidget({required this.status});

  @override
  Widget build(BuildContext context) {
    // Define colors for each status indicator
    final Map<String, Color> statusColors = {
      'Bebas': Colors.blue,
      'Rendah': Colors.green,
      'Sedang atau Tinggi': Colors.red,
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: statusColors.keys.map((key) {
        final isSelected = status == key;
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? statusColors[key]
                  : statusColors[key]!.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                key.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 8.0, // Ukuran font yang lebih kecil
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

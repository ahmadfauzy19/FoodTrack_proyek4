import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/NewsPage.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final bool showSeeAll;

  const TitleWidget({
    Key? key,
    required this.title,
    this.showSeeAll = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 3),
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          if (showSeeAll)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsPage()),
                );
              },
              child: const Row(
                children: [
                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 10,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

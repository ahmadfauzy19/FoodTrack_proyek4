import 'package:flutter/material.dart';

class Scanresult extends StatelessWidget {
  final Map<String, dynamic> data;

  const Scanresult({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> foods = data['data'];
    Map<String, dynamic> food = foods.isNotEmpty ? foods[0] : {};
    Map<String, dynamic> nutrition = food['gizi'] ?? {};

    return Scaffold(
      appBar: AppBar(title: Text('Detail Makanan')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              food['nama_makanan'] ?? 'Nama Makanan',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Informasi Nilai Gizi',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListView(
                children: [
                  _buildNutritionItem('Kalori', nutrition['kalori']),
                  _buildNutritionItem('Karbohidrat', nutrition['karbohidrat']),
                  _buildNutritionItem('Lemak', nutrition['lemak']),
                  _buildNutritionItem('Protein', nutrition['protein']),
                  _buildNutritionItem('Serat', nutrition['serat']),
                  _buildNutritionItem('Natrium', nutrition['natrium']),
                  _buildNutritionItem('Vitamin A', nutrition['vitamin_a']),
                  _buildNutritionItem('Vitamin B1', nutrition['vitamin_b1']),
                  _buildNutritionItem('Vitamin B2', nutrition['vitamin_b2']),
                  _buildNutritionItem('Vitamin B3', nutrition['vitamin_b3']),
                  _buildNutritionItem('Vitamin C', nutrition['vitamin_c']),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Produk Terkait',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRelatedProductItem('Product 1'),
                _buildRelatedProductItem('Product 2'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scanresult(data: data)),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text('Bandingkan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String label, dynamic value) {
    return ListTile(
      title: Text(label),
      trailing: Text(
        value != null ? '$value' : 'N/A',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRelatedProductItem(String name) {
    return Container(
      width: 165,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 500,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 217, 217),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.photo, color: Colors.white),
            ),
          ),
          // Judul
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

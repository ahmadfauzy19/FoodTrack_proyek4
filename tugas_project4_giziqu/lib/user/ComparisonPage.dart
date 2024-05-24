import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FoodImage extends StatelessWidget {
  final String imageUrl;

  const FoodImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getImageDownloadUrl(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Image.network(snapshot.data!);
        } else {
          return Text('No image available');
        }
      },
    );
  }

  Future<String> getImageDownloadUrl() async {
    try {
      final downloadUrl = await firebase_storage.FirebaseStorage.instance
          .ref('Images/MakananImage/$imageUrl')
          .getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting download URL: $e');
      throw e;
    }
  }
}

class PageComparation extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> data2;

  const PageComparation({Key? key, required this.data, required this.data2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> foods = data['data'];
    List<dynamic> foodsComparation = data2['data'];
    Map<String, dynamic> food = foods.isNotEmpty ? foods[0] : {};
    Map<String, dynamic> nutrition = food['gizi'] ?? {};
    Map<String, dynamic> foodComparation =
        foodsComparation.isNotEmpty ? foodsComparation[0] : {};
    Map<String, dynamic> nutritionComparation = foodComparation['gizi'] ?? {};

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            food['nama_makanan'] ?? 'Nama Makanan',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          // Gunakan widget FoodImage di sini untuk menampilkan gambar
          food['foto'] != null
              ? FoodImage(imageUrl: food['foto'])
              : Container(child: Text('No image')),
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
                _buildNutritionItem('Kalori', nutrition['kalori'],
                    nutritionComparation['kalori']),
                _buildNutritionItem('Karbohidrat', nutrition['karbohidrat'],
                    nutritionComparation['karbohidrat']),
                _buildNutritionItem(
                    'Lemak', nutrition['lemak'], nutritionComparation['lemak']),
                _buildNutritionItem('Protein', nutrition['protein'],
                    nutritionComparation['protein']),
                _buildNutritionItem(
                    'Serat', nutrition['serat'], nutritionComparation['serat']),
                _buildNutritionItem('Natrium', nutrition['natrium'],
                    nutritionComparation['natrium']),
                _buildNutritionItem('Vitamin A', nutrition['vitamin_a'],
                    nutritionComparation['vitamin_a']),
                _buildNutritionItem('Vitamin B1', nutrition['vitamin_b1'],
                    nutritionComparation['vitamin_b1']),
                _buildNutritionItem('Vitamin B2', nutrition['vitamin_b2'],
                    nutritionComparation['vitamin_b2']),
                _buildNutritionItem('Vitamin B3', nutrition['vitamin_b3'],
                    nutritionComparation['vitamin_b3']),
                _buildNutritionItem('Vitamin C', nutrition['vitamin_c'],
                    nutritionComparation['vitamin_c']),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Produk Terkait',
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(
      String label, dynamic value, dynamic comparisonValue) {
    Color backgroundColor = Colors.grey;
    if (value != null && comparisonValue != null) {
      num numericValue = (value is num) ? value : (num.tryParse(value) ?? 0);
      num numericComparisonValue = (comparisonValue is num)
          ? comparisonValue
          : (num.tryParse(comparisonValue) ?? 0);

      if (numericValue < numericComparisonValue) {
        backgroundColor = Colors.red;
      } else if (numericValue > numericComparisonValue) {
        backgroundColor = Colors.green;
      } else {
        backgroundColor = Colors.grey; // Jika sama, maka warna abu-abu
      }
    } else {
      backgroundColor =
          Colors.grey; // Jika salah satu nilai null, maka warna abu-abu
    }

    return Column(
      children: [
        Container(
          color: backgroundColor,
          child: ListTile(
            title: Text(label),
            trailing: Text(
              value != null ? '$value' : 'N/A',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        Divider(
          color: Colors.black12,
          thickness: 1.0,
          height: 0.0,
        ),
      ],
    );
  }
}

class ComparisonPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> data2;

  const ComparisonPage({Key? key, required this.data, required this.data2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Data 1: $data");
    print("Data 2: $data2");
    return Scaffold(
      appBar: AppBar(
        title: Text("Comparison Page"),
      ),
      body: PageView(
        children: [
          PageComparation(
            data: data,
            data2: data2,
          ),
          PageComparation(
            data: data2,
            data2: data,
          ),
        ],
      ),
    );
  }
}

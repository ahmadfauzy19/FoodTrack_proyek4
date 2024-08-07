import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/components/FoodImage.dart';
import 'package:tugas_project4_giziqu/components/GIziIndicator.dart';
import 'package:tugas_project4_giziqu/model/MakananModel.dart';

class ComparisonPage extends StatelessWidget {
  final List<Makanan> data;
  final List<Makanan> data2;

  const ComparisonPage({Key? key, required this.data, required this.data2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Data 1: $data");
    print("Data 2: $data2");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comparison Page"),
      ),
      body: PageView(
        children: [
          PageComparison(
            data: data,
            data2: data2,
          ),
          PageComparison(
            data: data2,
            data2: data,
          ),
        ],
      ),
    );
  }
}

class PageComparison extends StatelessWidget {
  final List<Makanan> data;
  final List<Makanan> data2;

  const PageComparison({Key? key, required this.data, required this.data2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Makanan food = data.isNotEmpty
        ? data[0]
        : Makanan(
            namaMakanan: '', foto: '', gizi: {}, jenis: '', label_gizi: {});
    Makanan foodComparison = data2.isNotEmpty
        ? data2[0]
        : Makanan(
            namaMakanan: '', foto: '', gizi: {}, jenis: '', label_gizi: {});

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            food.namaMakanan,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Gunakan widget FoodImage di sini untuk menampilkan gambar
          food.foto.isNotEmpty
              ? FoodImage(imageUrl: food.foto)
              : Container(child: const Text('No image')),
          const SizedBox(height: 20),
          const Text(
            'Informasi Nilai Gizi',
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListView(
              children: [
                _buildNutritionItem('Kalori', food.gizi['kalori'],
                    foodComparison.gizi['kalori'], "kcal"),
                _buildNutritionItem('Karbohidrat', food.gizi['karbohidrat'],
                    foodComparison.gizi['karbohidrat'], "gram"),
                _buildNutritionItem('Lemak', food.gizi['lemak'],
                    foodComparison.gizi['lemak'], "gram"),
                _buildNutritionItem('Protein', food.gizi['protein'],
                    foodComparison.gizi['protein'], "gram"),
                _buildNutritionItem('Serat', food.gizi['serat'],
                    foodComparison.gizi['serat'], "gram"),
                _buildNutritionItem('Natrium', food.gizi['natrium'],
                    foodComparison.gizi['natrium'], "gram"),
                _buildNutritionItem('Vitamin A', food.gizi['vitamin_a'],
                    foodComparison.gizi['vitamin_a'], "gram"),
                _buildNutritionItem('Vitamin B1', food.gizi['vitamin_b1'],
                    foodComparison.gizi['vitamin_b1'], "gram"),
                _buildNutritionItem('Vitamin B2', food.gizi['vitamin_b2'],
                    foodComparison.gizi['vitamin_b2'], "gram"),
                _buildNutritionItem('Vitamin B3', food.gizi['vitamin_b3'],
                    foodComparison.gizi['vitamin_b3'], "gram"),
                _buildNutritionItem('Vitamin C', food.gizi['vitamin_c'],
                    foodComparison.gizi['vitamin_c'], "gram"),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(
                16.0), // Menambahkan padding di sekeliling container
            decoration: BoxDecoration(
              color: Colors.grey[200], // Warna abu-abu muda
              borderRadius: BorderRadius.circular(10.0), // Sudut membulat
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Menyusun teks di kiri
              children: [
                Center(
                  child: const Text(
                    'Label Gizi',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Kalori',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                StatusWidget(
                  status: food.label_gizi['energi_label'],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Gula',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                StatusWidget(
                  status: food.label_gizi['gula_label'],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Lemak',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                StatusWidget(
                  status: food.label_gizi['lemak_label'],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Natrium',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                StatusWidget(
                  status: food.label_gizi['natrium_label'],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(
      String label, dynamic value, dynamic comparisonValue, String satuan) {
    Color backgroundColor = Colors.grey;
    if (value != null && comparisonValue != null) {
      num numericValue = (value is num) ? value : (num.tryParse(value) ?? 0);
      num numericComparisonValue = (comparisonValue is num)
          ? comparisonValue
          : (num.tryParse(comparisonValue) ?? 0);

      if (numericValue < numericComparisonValue) {
        backgroundColor = const Color.fromARGB(255, 255, 108, 98);
      } else if (numericValue > numericComparisonValue) {
        backgroundColor = const Color.fromARGB(255, 108, 255, 113);
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
              value != null ? '$value $satuan' : 'N/A',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        const Divider(
          color: Colors.black12,
          thickness: 1.0,
          height: 0.0,
        ),
      ],
    );
  }
}

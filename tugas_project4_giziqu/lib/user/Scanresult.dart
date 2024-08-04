// ignore_for_file: use_build_context_synchronously, avoid_print, unnecessary_null_comparison, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/SearchComparisonPage.dart';
import 'package:tugas_project4_giziqu/components/FoodImage.dart';
import 'package:tugas_project4_giziqu/components/GIziIndicator.dart';
import 'package:tugas_project4_giziqu/model/MakananModel.dart';
import 'package:tugas_project4_giziqu/services/makanan_service.dart';

class Scanresult extends StatefulWidget {
  final List<Makanan> data;

  const Scanresult({Key? key, required this.data}) : super(key: key);

  @override
  _ScanresultState createState() => _ScanresultState();
}

class _ScanresultState extends State<Scanresult> {
  late Future<List<Makanan>> relatedProducts;

  @override
  void initState() {
    super.initState();
    relatedProducts = fetchRelatedProducts();
    print(relatedProducts);
  }

  Future<List<Makanan>> fetchRelatedProducts() async {
    if (widget.data.isNotEmpty) {
      String jenis = widget.data[0].jenis;
      return await MakananService.fetchMakananByJenis(jenis);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Makanan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data.isNotEmpty
                  ? widget.data[0].namaMakanan
                  : 'Nama Makanan',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Gunakan widget FoodImage di sini untuk menampilkan gambar
            widget.data.isNotEmpty && widget.data[0].foto != null
                ? FoodImage(imageUrl: widget.data[0].foto)
                : const Text('No image available'),
            const SizedBox(height: 20),

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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    status: widget.data[0].label_gizi['energi_label'],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Gula',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  StatusWidget(
                    status: widget.data[0].label_gizi['gula_label'],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Lemak',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  StatusWidget(
                    status: widget.data[0].label_gizi['lemak_label'],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Natrium',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  StatusWidget(
                    status: widget.data[0].label_gizi['natrium_label'],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const Text(
              'Informasi Nilai Gizi',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 237, 237, 237),
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListView(
                children: [
                  _buildNutritionItem(
                      'Kalori',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['energi']
                          : null,
                      "kcal"),
                  _buildNutritionItem(
                      'Karbohidrat',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['karbohidrat']
                          : null,
                      "gram"),
                  _buildNutritionItem(
                      'Lemak',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['lemak']
                          : null,
                      "gram"),
                  _buildNutritionItem(
                      'Protein',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['protein']
                          : null,
                      "gram"),
                  _buildNutritionItem(
                      'Serat',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['serat']
                          : null,
                      "gram"),
                  _buildNutritionItem(
                      'Natrium',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['natrium']
                          : null,
                      "gram"),
                  _buildNutritionItem(
                      'Vitamin A',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['vitamin_a']
                          : null,
                      "gram"),
                  _buildNutritionItem(
                      'Vitamin B1',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['vitamin_b1']
                          : null,
                      "gram"),
                  _buildNutritionItem(
                      'Vitamin B2',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['vitamin_b2']
                          : null,
                      "gram"),
                  _buildNutritionItem(
                      'Vitamin B3',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['vitamin_b3']
                          : null,
                      "gram"),
                  _buildNutritionItem(
                      'Vitamin C',
                      widget.data.isNotEmpty
                          ? widget.data[0].gizi['vitamin_c']
                          : null,
                      "gram"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Produk Terkait',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Makanan>>(
              future: relatedProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No related products found.');
                } else {
                  // Cetak nilai dari relatedProducts di sini
                  print("relatedProducts: ${snapshot.data}");
                  return Row(
                    children: snapshot.data!
                        .map((makanan) => _buildRelatedProductItem(makanan))
                        .toList(),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchComparisonPage(data: widget.data),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Bandingkan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String label, dynamic value, String satuan) {
    return Column(
      children: [
        ListTile(
          title: Text(label),
          trailing: Text(
            value != null ? '$value $satuan' : 'N/A',
            style: const TextStyle(fontWeight: FontWeight.bold),
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

  Widget _buildRelatedProductItem(Makanan makanan) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          try {
            List<Makanan> makananList =
                await MakananService.searchMakanan(makanan.namaMakanan);
            if (makananList.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scanresult(data: makananList),
                ),
              );
            } else {
              print('Data makanan tidak ditemukan');
              // Handle ketika data makanan tidak ditemukan, misalnya dengan menampilkan snackbar atau dialog
            }
          } catch (e) {
            print('Exception saat searching makanan: $e');
            // Handle exception, misalnya dengan menampilkan snackbar atau dialog
          }
        },
        child: Container(
          width: 200, // Sesuaikan lebar sesuai kebutuhan
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 120, // Tinggi gambar produk
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 217, 217),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: FoodImage(imageUrl: makanan.foto),
              ),
              // Judul
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  makanan.namaMakanan,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

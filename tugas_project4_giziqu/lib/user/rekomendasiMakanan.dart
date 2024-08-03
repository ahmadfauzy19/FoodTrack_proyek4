import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/components/RekomendedFoodImage.dart';
import 'package:tugas_project4_giziqu/global/LoadingProgress.dart';
import 'package:tugas_project4_giziqu/model/MakananModel.dart';
import 'package:tugas_project4_giziqu/services/makanan_service.dart';
import 'package:tugas_project4_giziqu/user/Scanresult.dart';

class RekomendasiMakanan extends StatefulWidget {
  const RekomendasiMakanan({Key? key}) : super(key: key);

  @override
  State<RekomendasiMakanan> createState() => _RekomendasiMakananPage();
}

class _RekomendasiMakananPage extends State<RekomendasiMakanan> {
  List<Makanan> makananList = [];
  User? currentUser;
  String? userEmail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMakananList();
  }

  Future<void> _loadMakananList() async {
    currentUser = FirebaseAuth.instance.currentUser;
    userEmail = currentUser?.email;
    if (userEmail != null) {
      try {
        final response =
            await MakananService.fetchRecomendasiMakanan(userEmail!);
        print('response : ${response.map((e) => e)}');
        setState(() {
          makananList = response.map((e) => e).toList();
          isLoading = false;
        });
      } catch (e) {
        print('Error fetching makanan: $e');
        setState(() {
          isLoading = false;
        });
        _showErrorSnackBar('Error fetching makanan: $e');
      }
    } else {
      print('No user email found');
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar('Email tidak ditemukan');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFB71C1C),
        action: SnackBarAction(
          label: 'Tutup',
          onPressed: () {},
          textColor: Colors.yellow,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekomendasi Makanan'),
      ),
      body: isLoading
          ? const _LoadingIndicator()
          : ListView.builder(
              itemCount: makananList.length,
              itemBuilder: (context, index) {
                final makanan = makananList[index];
                return _MakananCard(
                  makanan: makanan,
                  makananList: makananList,
                );
              },
            ),
    );
  }
}

class _MakananCard extends StatelessWidget {
  final Makanan makanan;
  final List<Makanan> makananList;

  const _MakananCard(
      {Key? key, required this.makanan, required this.makananList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: RecommendedFoodImage(
            imageUrl: makanan.foto,
            width: 80,
            height: 80,
          ),
          title: Text(
            makanan.namaMakanan,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          trailing: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scanresult(data: makananList),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.green,
            ),
            child: const Text('Lihat'),
          ),
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: LoadingDialog(pesan: "mencari data."));
  }
}

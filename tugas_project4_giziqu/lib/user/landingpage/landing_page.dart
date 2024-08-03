// ignore_for_file: avoid_print, unnecessary_null_comparison, file_names, unnecessary_const

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/model/ArtikelModel.dart';
import '../../global/LoadingProgress.dart';
import '../../global/bottom_app_bar/bottom_app_bar_widget.dart';
import '../../global/bottom_app_bar/floating_action_button_widget.dart';
import '../../model/DataUser.dart';
import '../../services/GetDataUser.dart';
import 'header_widget.dart';
import 'body_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? currentUser;
  Future<DataUser?>? futureDataUser;
  Future<Artikel?>? futureArtikel;
  String imageUrl = '';
  UserService userService = UserService();
  DataUser? dataUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    var userEmail = currentUser?.email;
    if (userEmail != null) {
      futureDataUser = userService.getDataUser(userEmail);
      futureDataUser!.then((data) {
        setState(() {
          dataUser = data;
          imageUrl = data?.foto ?? '';
        });
      });
    }
  }

  Future<void> _refreshData() async {
    if (currentUser != null) {
      var userEmail = currentUser!.email;
      if (userEmail != null) {
        setState(() {
          futureDataUser = userService.getDataUser(userEmail);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 102, 183, 65),
      body: FutureBuilder<DataUser?>(
        future: futureDataUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingDialog(pesan: "Loading."));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found'));
          } else {
            DataUser dataUser = snapshot.data!;
            return RefreshIndicator(
              color: Colors.lightGreen,
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: Column(
                    children: [
                      HeaderWidget(
                          dataUser: dataUser,
                          imageUrl: imageUrl,
                          currentUser: currentUser),
                      const BodyWidget(),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: const FloatingActionButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}

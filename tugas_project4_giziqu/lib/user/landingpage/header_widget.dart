// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/ProfileImage/ProfilImageBuilder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tugas_project4_giziqu/model/DataUser.dart';

class HeaderWidget extends StatelessWidget {
  final DataUser dataUser;
  final String imageUrl;
  final User? currentUser;

  const HeaderWidget({
    Key? key,
    required this.dataUser,
    required this.imageUrl,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/BG.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          if (dataUser != null)
            ProfileImageBuilder(
              username: dataUser.username,
              imageUrl: imageUrl,
              activateTap: false,
            )
          else
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/default.jpeg"),
            ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Selamat Datang,",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  currentUser != null
                      ? currentUser!.displayName ?? "Guest"
                      : "Guest",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

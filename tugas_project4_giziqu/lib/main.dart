// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'GiziQuApp.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyAxJCy3xkHF1iOG9ugk8Jb7F4kxwEEmHjo",
      authDomain: "giziqu-14e75.firebaseapp.com",
      projectId: "giziqu-14e75",
      appId: "1:452585413053:android:778cfeacf7cf35954e1ad4",
      messagingSenderId: "452585413053",
      storageBucket: "gs://giziqu-14e75.appspot.com",
    ));
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(const GiziQuApp());
}

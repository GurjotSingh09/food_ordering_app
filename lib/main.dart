import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delievery_app/admin/add_food.dart';
import 'package:food_delievery_app/admin/admin_login.dart';
import 'package:food_delievery_app/admin/home_admin.dart';
import 'package:food_delievery_app/pages/bottomNavigation.dart';
import 'package:food_delievery_app/pages/forgot_password.dart';
import 'package:food_delievery_app/pages/home.dart';
import 'package:food_delievery_app/pages/login.dart';
import 'package:food_delievery_app/pages/onboard.dart';
import 'package:food_delievery_app/pages/profile.dart';
import 'package:food_delievery_app/pages/signUp.dart';
import 'package:food_delievery_app/pages/wallet.dart';
import 'package:food_delievery_app/widgets/app_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  Platform.isAndroid
      ? await Firebase.initializeApp(

          options: const FirebaseOptions(
              apiKey: "AIzaSyATPH2_Dh54ut58qwRdstRRhis8hr5LboU",
              appId: "1:934270349425:android:d4a724cbf154181e5c2bd0",
              messagingSenderId: "934270349425",
              projectId: "fooddelievery-app",
              storageBucket:"fooddelievery-app.appspot.com" ,
              authDomain:"fooddelievery-app.firebaseapp.com",
          )

  )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:Onboard(),
    );
  }
}


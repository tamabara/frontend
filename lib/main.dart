import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:slash_2022_2/screens/tama.dart';
import 'package:slash_2022_2/utils/globals.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/result.dart';

import 'utils/colors.dart';
import 'utils/models.dart';

import 'utils/globals.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  prefs = await SharedPreferences.getInstance();
  score = load_score();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 500),
      defaultTransition: Transition.fadeIn,
      theme: ThemeData(
        primaryColor: green,
        backgroundColor: vanilla,
        scaffoldBackgroundColor: vanilla,
        appBarTheme: const AppBarTheme(
          backgroundColor: vanilla,
          surfaceTintColor: vanilla,
          shadowColor: shadow
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: green
        ),
        textTheme: GoogleFonts.vt323TextTheme(Theme.of(context).textTheme),
        useMaterial3: true
      ),
      home: const TamaScreen()
    );
  }
}

// void createGlobalProduct(Product productData) {
//   productTitle = productData.title;
//   productNutriScore = productData.nutri_score;
//   productCarbonScore = productData.carbon_score;
//   productImageUrl = productData.image_url;
// }

int load_score() {
  return prefs.getInt("score") ?? 0;
}

Future <void> save_score(int score) async {
  await prefs.setInt("score", score);
}
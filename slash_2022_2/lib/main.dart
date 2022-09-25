import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:slash_2022_2/utils/globals.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'screens/home.dart';
import 'screens/result.dart';

import 'utils/colors.dart';
import 'utils/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        transitionDuration: const Duration(milliseconds: 500),
        defaultTransition: Transition.fadeIn,
        getPages: [
          GetPage(
            name: '/',
            page: () => const HomeScreen(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/result',
            page: () => const ResultScreen(),
            transition: Transition.rightToLeft,
          ),
        ],
        theme: ThemeData(
            primaryColor: green,
            backgroundColor: vanilla,
            scaffoldBackgroundColor: vanilla,
            appBarTheme: const AppBarTheme(
                backgroundColor: vanilla,
                surfaceTintColor: vanilla,
                shadowColor: shadow),
            textTheme: GoogleFonts.soraTextTheme(Theme.of(context).textTheme),
            useMaterial3: true));
  }
}

void postRequest(String? bardcodeScanRes) async {
  var url = Uri(
    scheme: 'https',
    host: 'fastapi-backend-slash2022.vercel.app',
    path: 'product/info',
  );

  Map data = {"ean": bardcodeScanRes};
  //encode Map to JSON

  var body = json.encode(data);
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: body);
  print("${response.statusCode}");
  print("${response.body}");
  var productData = Product.fromJson(jsonDecode(response.body));
  createGlobalProduct(productData);
  Get.offNamed('/result');
}

void createGlobalProduct(Product productData) {
  productTitle = productData.title;
  productNutriScore = productData.nutri_score;
  productCarbonScore = productData.carbon_score;
}

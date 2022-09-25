import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:slash_2022_2/screens/tama.dart';
import 'package:slash_2022_2/utils/globals.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home.dart';
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
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: vanilla
        ),
        textTheme: GoogleFonts.vt323TextTheme(Theme.of(context).textTheme),
        useMaterial3: true
      ),
      home: const Navbar()
    );
  }
}

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  List<Widget> _screens = [const HomeScreen(), const TamaScreen()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Tama',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped
      ),
      body: SafeArea(
        child: _screens[_selectedIndex]
      ),
    );
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
  Get.back();
  Get.to(const ResultScreen());
}

void createGlobalProduct(Product productData) {
  productTitle = productData.title;
  productNutriScore = productData.nutri_score;
  productCarbonScore = productData.carbon_score;
}

int load_score() {
  return prefs.getInt("score") ?? 0;
}

Future <void> save_score(int score) async {
  await prefs.setInt("score", score);
}
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'screens/home.dart';
import 'utils/colors.dart';

void main() async {
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
        ],
        theme: ThemeData(
          primaryColor: green,
          backgroundColor: vanilla,
          scaffoldBackgroundColor: vanilla,
          appBarTheme: const AppBarTheme(
            backgroundColor: vanilla,
            surfaceTintColor: vanilla,
            shadowColor: shadow
          ),
          textTheme: GoogleFonts.soraTextTheme(Theme.of(context).textTheme),
          useMaterial3: true
        ));
  }
}

// Future<http.Response> postRequest () async {
//   Uri url ='https://fastapi-backend-slash2022.vercel.app/docs/product/info';
//   var body = jsonEncode({ 'data': { 'apikey': '12345678901234567890' } });

//   print("Body: " + body);

//   http.post(url,
//       headers: {"Content-Type": "application/json"},
//       body: body
//   ).then((http.Response response) {
//     print("Response status: ${response.statusCode}");
//     print("Response body: ${response.contentLength}");
//     print(response.headers);
//     print(response.request);

//   });
//   return body;
// }

Future<http.Response> postRequest() async {
  // var url ='https://fastapi-backend-slash2022.vercel.app/docs/product/info';
  var url = Uri(
    scheme: 'https',
    host: 'fastapi-backend-slash2022.vercel.app',
    path: 'product/info',
  );

  Map data = {"ean": "string"};
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: body);
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}

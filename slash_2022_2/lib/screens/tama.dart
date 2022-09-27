// Packages
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_zxing/flutter_zxing.dart';

// Screens
import './barcode_scanner.dart';
import './result.dart';

// Models
import '../utils/models.dart';

// Widgets
import '../widgets/icnbutton.dart';

// Globals
import '../utils/globals.dart';

class TamaScreen extends StatefulWidget {
  const TamaScreen({super.key});

  @override
  State<TamaScreen> createState() => _TamaScreenState();
}

class _TamaScreenState extends State<TamaScreen> {
  bool happy = false;

  // function to load product from server
  Future<Product?> getProduct(String barcode) async {
    http.Response response = await http.post(
      Uri(scheme: 'https', host: 'api.tamabara.com', path: 'product/info'), 
      headers: {"Content-Type": "application/json"}, 
      body: json.encode({"ean": barcode})
    );
    print("${response.statusCode}");
    print("${response.body}");
    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

          // About Page
          IcnButton(
            margin: const EdgeInsets.all(13.0),
            icondata: Icons.info_outline_rounded,
            onPressed: () => showAboutDialog(
              context: context,
              applicationIcon: SvgPicture.asset("assets/logo2.svg", width: 100),
              applicationVersion: "V1.0",
              applicationLegalese: "This app is free to use"
            )
          )
        ],
      ),

      // Barcode Scan Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => BarcodeScanner(onScan: (CodeResult value) async {
            // load product
            Product? product = await getProduct(value.textString!);
            // get back to mainscreen
            Get.back();
            // if no product was returned or an error was encountered
            if (product == null) {
              Get.snackbar("Error", "An unknown error occured!");
            // if product was loaded, show on ResultScreen
            } else {
              Get.to(() => ResultScreen(product: product));
            }
          }), popGesture: false);
        },
        child: const Icon(Icons.qr_code_scanner),
      ),

      // Page Content
      body: SafeArea(
        child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Score Text
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: Text("Score: $score", style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                ),

                // Food Bowl Stack
                Stack(
                  children: [

                    // Food Draggable
                    Container(
                      alignment: Alignment.center,
                      child: newscores.isNotEmpty ? Draggable(
                        data: newscores.first,
                        feedback: productTitle == 'Club-Mate' ? Image.asset('assets/club_mate_pixel.png', width: 80) : SvgPicture.asset(
                          "assets/donut.svg",
                          width: 120,
                        ),
                        childWhenDragging: productTitle == 'Club-Mate' ? Container() : SvgPicture.asset(
                          "assets/donut.svg ",
                          width: 80,
                          color: Colors.grey,
                        ),
                        child: productTitle == 'Club-Mate' ? Image.asset('assets/club_mate_pixel.png', width: 80) : SvgPicture.asset(
                          "assets/donut.svg",
                          width: 80,
                        ),
                      ) : Container(),
                    ),

                    // Bowl Image
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/bowl.svg",
                        width: 80
                      )
                    )
                  ]
                ),
              ],
            )
          ),

          // Centedred Tamabara
          Center(
            child: DragTarget(

              // On Drop On Target
              onAccept: (int data) async {
                score += data;
                newscores.remove(data);
                setState(() {
                  happy = true;
                });
                Future.delayed(const Duration(milliseconds: 1800)).then((value) {
                  setState(() {
                    happy = false;
                  });
                });
              },

              // Tamabara Builder
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected
              ) {
                return Container(
                  child: happy ? Image.asset(
                    "assets/happy.gif",
                    width: 280
                  ) : Image.asset(
                    "assets/idle.gif",
                    width: 280
                  )
                );
              }
            )
          )
        ]
      )
      )
    );
  }
}
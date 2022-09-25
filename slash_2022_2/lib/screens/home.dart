import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:slash_2022_2/main.dart';
import '../utils/barcode_scanner.dart';

import '../utils/colors.dart';

void getBarcode() async {
  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    '#ff6666',
    'cancel',
    false,
    ScanMode.BARCODE,
  );
  postRequest(barcodeScanRes);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 385),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/logo2.svg',
                    width: 300
                  ),
                )),
            Center(
                child: OutlinedButton(
              onPressed: () =>
                  Get.to(BarcodeScanner(onScan: (CodeResult value) {
                postRequest(value.textString);
              })),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 2.0, color: darkGreen)),
              child: const Text(
                'Scan',
                style: TextStyle(color: darkGreen)
              ),
            ))
          ],
        ));
  }
}

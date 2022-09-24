import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:io/ansi.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../utils/colors.dart';

void getBarcode() async {
  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    '#ff6666',
    'cancel',
    false,
    ScanMode.BARCODE,
  );
  print(barcodeScanRes);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: vanilla,
        ),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.only(bottom: 400),
                child: Center(
                  child: SvgPicture.asset(
                    '/Users/fiodaryuzhyk/slash_frontend/slash_2022_2/assets/slash_logo.svg',
                    semanticsLabel: 'TamabaraLogo',
                    width: 300,
                  ),
                )),
            Center(
              child: OutlinedButton(
              onPressed: () => getBarcode(),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 2.0, color: darkGreen)),
              child: Text(
                "Scan",
                style: TextStyle(color: darkGreen),
              ),
            ))
          ],
        ));
  }
}

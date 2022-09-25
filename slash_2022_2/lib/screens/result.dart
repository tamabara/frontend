import 'dart:ffi';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:io/ansi.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:slash_2022_2/main.dart';
import 'package:slash_2022_2/utils/globals.dart';

import '../utils/colors.dart';
import '../utils/models.dart';

SvgPicture? getNutriScore(productNutriScore) {
  if (productNutriScore == 'a') {
    return SvgPicture.asset(
      'assets/nutriscore-a.svg',
      width: 100,
    );
  } else if (productNutriScore == 'b') {
    return SvgPicture.asset(
      'assets/nutriscore-b.svg',
      width: 100,
    );
  } else if (productNutriScore == 'c') {
    return SvgPicture.asset(
      'assets/nutriscore-c.svg',
      width: 100,
    );
  } else if (productNutriScore == 'd') {
    return SvgPicture.asset(
      'assets/nutriscore-d.svg',
      width: 100,
    );
  } else if (productNutriScore == 'e') {
    return SvgPicture.asset(
      'assets/nutriscore-e.svg',
      width: 100,
    );
  } else
    return null;
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: vanilla
      ),
      body: Column(children: [
        Center(child:
          Container(
            padding: EdgeInsets.only(bottom: 15),
            child:
              Text(productTitle, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),))),
        Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child:
              productTitle == 'Club-Mate' ? Image.asset('assets/club_mate.jpg') : null),
          ),
        Center(
          child: getNutriScore(productNutriScore)
        ),
        Center(child:
          Container(
            padding: EdgeInsets.all(10),
            child:
              Text("Carbon Score:", style: TextStyle(fontSize: 28),)),
        ),
        Center(child:
          Text(productCarbonScore.toString(), style: TextStyle(fontSize: 28, color: productCarbonScore > 70 ? Colors.green : Colors.orange),)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(side: BorderSide(width: 2.0, color: darkGreen)),
              child: Text("Back", style: TextStyle(color: darkGreen)),
              onPressed: () => Get.offNamed('/')
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(side: BorderSide(width: 2.0, color: darkGreen)),
              child: Text("Feed!", style: TextStyle(color: darkGreen)),
              onPressed: () {
                Get.snackbar("Success", "Successfully added product to food bowl", backgroundColor: Colors.green.withOpacity(0.5));
                newscores.add(productCarbonScore);
              }
            )
          ],
        ),
      ]),
    );
  }
}

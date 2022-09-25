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
    );
  } else if (productNutriScore == 'b') {
    return SvgPicture.asset(
      'assets/nutriscore-b.svg',
    );
  } else if (productNutriScore == 'c') {
    return SvgPicture.asset(
      'assets/nutriscore-c.svg',
    );
  } else if (productNutriScore == 'd') {
    return SvgPicture.asset(
      'assets/nutriscore-d.svg',
    );
  } else if (productNutriScore == 'e') {
    return SvgPicture.asset(
      'assets/nutriscore-e.svg',
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
        backgroundColor: vanilla,
      ),
      body: Column(children: [
        Center(child: Text(productTitle)),
        Center(child: Text(productNutriScore)),
        Center(child: Text(productCarbonScore.toString())),
        Center(
          child: getNutriScore(productNutriScore)
        ),
        // Center(
        //   child: productNutriScore == 'd'
        //       ? SvgPicture.asset(
        //           'assets/nutriscore-d.svg',
        //           width: 200,
        //         )
        //       : null,
        // ),
        // Center(
        //   child: productNutriScore == 'c'
        //       ? SvgPicture.asset(
        //           'assets/nutriscore-c.svg',
        //           width: 200,
        //         )
        //       : null,
        // ),
        // Center(
        //   child: productNutriScore == 'b'
        //       ? SvgPicture.asset(
        //           'assets/nutriscore-b.svg',
        //           width: 200,
        //         )
        //       : null,
        // ),
        // Center(
        //   child: productNutriScore == 'a'
        //       ? SvgPicture.asset(
        //           'assets/nutriscore-a.svg',
        //           width: 200,
        //         )
        //       : null,
        // ),
      ]),
    );
  }
}

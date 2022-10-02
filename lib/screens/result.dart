import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart' as colors;
import '../utils/models.dart';
import '../utils/globals.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.product});

  final Product product;

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
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Flexible(child: Container(
            margin: const EdgeInsets.only(bottom: 15.0),
            child: Text(product.title, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
          )),
          Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: product.imageurl != null ? Image.asset('assets/club_mate.jpg') : Image.asset('assets/noproductimage.png', width: 300)
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: getNutriScore(product.nutriscore)
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black, width: 2.0)
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text("Carbon Score:", style: TextStyle(fontSize: 28)),
                Text(product.carbonscore.toString(), style: TextStyle(fontSize: 28, color: product.carbonscore > 70 ? Colors.green : Colors.orange))
              ],
            )
          ),
          CupertinoButton(onPressed: (){
            Get.snackbar("Success", "Successfully added product to food bowl", backgroundColor: Colors.green.withOpacity(0.5));
            newscores.add(product.carbonscore);
          }, color: colors.green, child: Text("Add to bowl", style: GoogleFonts.vt323TextTheme(Theme.of(context).textTheme).titleMedium)),
          // OutlinedButton(
          //   style: OutlinedButton.styleFrom(side: const BorderSide(width: 2.0, color: darkGreen), padding: const EdgeInsets.symmetric(horizontal: 80.0)),
          //   child: const Text("Feed!", style: TextStyle(color: darkGreen)),
          //   onPressed: () {
          //     Get.snackbar("Success", "Successfully added product to food bowl", backgroundColor: Colors.green.withOpacity(0.5));
          //     newscores.add(product.carbonscore);
          //   }
          // )
      ]),
    );
  }
}

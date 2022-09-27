import 'package:shared_preferences/shared_preferences.dart';

var productTitle = null;

var productNutriScore = null;

var productCarbonScore = null;

var productImageUrl = null;

late SharedPreferences prefs;
late int score;
List<int> newscores = [];
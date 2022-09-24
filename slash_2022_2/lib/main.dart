import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666',
            'cancel',
            true,
            ScanMode.BARCODE,
          );
          debugPrint(barcodeScanRes);
          postRequest();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
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

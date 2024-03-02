import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

Future getSearch() async {
  const String apiUrl = 'https://itunes.apple.com/search?term=jack+johnson';
  final http.Response response = await http.get(Uri.parse(apiUrl));
  print(response.body);
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    getSearch();
    return const Scaffold();
  }
}

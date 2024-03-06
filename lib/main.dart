import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itunes_api/model/itunes_model.dart';
import 'package:itunes_api/widgets/Card.dart';

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

List<Song> songResult = [];

Future getSearch() async {
  const String apiUrl =
      'https://itunes.apple.com/search?term=jack+johnson&limit=1';
  final http.Response response = await http.get(Uri.parse(apiUrl));
  parseJson(response);
}

parseJson(http.Response response) {
  var jsonData = jsonDecode(response.body);

  for (var eachResult in jsonData['results']) {
    final result = Song(
        artistName: eachResult['artistName'],
        trackName: eachResult['trackName'],
        artworkUrl60: eachResult['artworkUrl60']);
    songResult.add(result);
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    getSearch();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("iTunes"),
      ),
      body: FutureBuilder(
        future: getSearch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: songResult.length,
                itemBuilder: (context, index) {
                  return CardTile(
                      title: songResult[index].trackName,
                      subtitle: songResult[index].artistName,
                      webUrl: songResult[index].artworkUrl60);
                });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Error loading data'));
          }
        },
      ),
    );
  }
}

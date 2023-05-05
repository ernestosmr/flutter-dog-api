import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/image_models.dart';
import 'widgets/images_list.dart';

class App extends StatefulWidget {
  @override
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  final url = 'https://api.thedogapi.com/v1/images/search?limit=1';
  final apiKey =
      'live_uDoTS6qfEDp4Jt4tvpcqTRrEbrpdHETIwPVEDs1gpFZUVX4oL3A4XGIMhp9Ux4mB';
  void fetchImage() async {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'x-api-key': apiKey,
      },
    );
    ImageModel imageModel = ImageModel.fromJson(json.decode(response.body)[0]);
    if (!images.any((element) => element.id == imageModel.id)) {
      setState(() {
        images.add(imageModel);
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: ImageList(images),
        appBar: AppBar(
          title: const Text("Let's see some images!"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

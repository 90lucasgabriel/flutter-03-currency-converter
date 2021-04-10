import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Uri request = Uri.parse("https://api.hgbrasil.com/finance?key=d990ecda");

void main() async {
  http.Response response = await http.get(request);
  print(json.decode(response.body));

  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency Converter"),
      ),
      body: Column(
        children: <Widget>[
          Container(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Uri request = Uri.parse("https://api.hgbrasil.com/finance?key=d990ecda");

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.white38,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white38,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    ),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);

  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  double dollar;
  double euro;

  void _handleRealChanged(String value) {
    print("Real $value");
  }

  void _handleDollarChanged(String value) {
    print("Dollar $value");
  }

  void _handleEuroChanged(String value) {
    print("Euro $value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      appBar: AppBar(
        title: Text(
          "Currency Converter",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.amber[700],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar os dados",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                );
              } else {
                dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.white,
                        size: 150,
                      ),
                      Divider(
                        height: 32,
                        color: Colors.transparent,
                      ),
                      buildTextField("Brazilian real", "R\$ ", realController,
                          _handleRealChanged),
                      Divider(
                        height: 16,
                        color: Colors.transparent,
                      ),
                      buildTextField("United States dollar", "US\$ ",
                          dollarController, _handleDollarChanged),
                      Divider(
                        height: 16,
                        color: Colors.transparent,
                      ),
                      buildTextField(
                          "Euro", "€ ", euroController, _handleEuroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(String label, String prefix,
    TextEditingController controller, Function onChanged) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(),
      prefixText: prefix,
    ),
    style: TextStyle(
      color: Colors.white,
      fontSize: 25,
    ),
  );
}

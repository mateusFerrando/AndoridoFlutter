import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=60df7606";

void main() async {
  print(await getData());
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}

Future<Map> getData() async {
  http.Response resposta = await http.get(request);
  return json.decode(resposta.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dollar = 0.0;
  double euro = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Conversor de Moedas",
        ),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando Dados",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar dados",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        TextField(
                            decoration: InputDecoration(
                          labelText: "Reais",
                          labelStyle:
                              TextStyle(color: Colors.amber, fontSize: 25.0),
                          border: OutlineInputBorder(),
                          prefixText: "R\$",
                        )),
                        TextField(
                            decoration: InputDecoration(
                          labelText: "Dollars",
                          labelStyle:
                              TextStyle(color: Colors.amber, fontSize: 25.0),
                          border: OutlineInputBorder(),
                          prefixText: "\$",
                        )),
                        TextField(
                            decoration: InputDecoration(
                          labelText: "Euros",
                          labelStyle:
                              TextStyle(color: Colors.amber, fontSize: 25.0),
                          border: OutlineInputBorder(),
                          prefixText: "\$",
                        )),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

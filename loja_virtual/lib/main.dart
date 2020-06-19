import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter\'s Clothes',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          secondaryHeaderColor: Color.fromARGB(255, 4, 125, 100)),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

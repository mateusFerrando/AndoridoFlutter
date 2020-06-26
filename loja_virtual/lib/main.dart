import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: 'Flutter\'s Clothes',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            secondaryHeaderColor: Color.fromARGB(255, 4, 125, 100)),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatonline/chat_screen.dart';

void main() async {
  runApp(MyApp());
  QuerySnapshot snapshot =
      await Firestore.instance.collection("mensagens").getDocuments();
  snapshot.documents.forEach((d) {
    print(d.data);
  });
}

void inserir() {
  Firestore.instance
      .collection("mensagens")
      .document()
      .setData({"texto": "Olá", "from": "Daniel", "lida": true});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat Flutter",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          iconTheme: IconThemeData(color: Colors.blue)),
      home: ChatScreen(),
    );
  }
}

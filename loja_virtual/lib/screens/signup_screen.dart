import 'package:flutter/material.dart';

class SingnupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar conta'),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Nome completo"),
              validator: (text) {
                if (text.isEmpty) return "Nome completo inválido";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Senha"),
              validator: (text) {
                if (text.isEmpty || text.length < 6) return "Senha inválido";
              },
              obscureText: true,
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Endereço "),
              validator: (text) {
                if (text.isEmpty) return "Endereço inválido";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                child: Text(
                  "Criar conta",
                  style: TextStyle(fontSize: 18.0),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()) {

                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SingnupScreen extends StatefulWidget {
  @override
  _SingnupScreenState createState() => _SingnupScreenState();
}

class _SingnupScreenState extends State<SingnupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameControler = TextEditingController();
  final _passControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _enderecoControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Criar conta'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameControler,
                  decoration: InputDecoration(hintText: "Nome completo"),
                  validator: (text) {
                    if (text.isEmpty) return "Nome completo inválido";
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passControler,
                  decoration: InputDecoration(hintText: "Senha"),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválido";
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _emailControler,
                  decoration: InputDecoration(hintText: "E-mail"),
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "E-mail inválido";
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _enderecoControler,
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
                        Map<String, dynamic> userData = {
                          "name": _nameControler.text,
                          "email": _emailControler.text,
                          "addres": _enderecoControler.text,
                        };
                        model.signUp(
                            userData: userData,
                            pass: _passControler.text,
                            onSucces: _onSucces,
                            onFail: _onFail);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSucces() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Erro ao criar usuário"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}

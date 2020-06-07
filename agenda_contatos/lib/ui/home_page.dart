import 'dart:io';

import 'package:agendacontatos/helpers/contact_helper.dart';
import 'package:agendacontatos/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions { orderAZ, orderZA }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contatos = new List();

  @override
  void initState() {
    super.initState();
    _getAllContact();
  }

  void _getAllContact() {
    helper.getAllContact().then((list) {
      setState(() {
        contatos = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de A-Z"),
                value: OrderOptions.orderAZ,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de Z-A"),
                value: OrderOptions.orderZA,
              )
            ],
            onSelected: _orderList,
          )
        ],
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: _showContactPage,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          itemCount: contatos.length,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) {
            return _cardContato(context, index);
          }),
    );
  }

  Widget _cardContato(context, index) {
    return GestureDetector(
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: contatos[index].img == null
                                ? AssetImage("images/person.png")
                                : FileImage(File(contatos[index].img)))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          contatos[index].name ?? "",
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          contatos[index].email ?? "",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          contatos[index].phone ?? "",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    botoesContato("Ligar", () {
                      launch("tel:${contatos[index].phone}");
                    }),
                    botoesContato("Editar", () {
                      Navigator.pop(context);
                      _showContactPage(contact: contatos[index]);
                    }),
                    botoesContato("Excluir", () {
                      setState(() {
                        helper.deleteContact(contatos[index].id);
                        contatos.removeAt(index);
                        Navigator.pop(context);
                      });
                    }),
                  ],
                ),
              );
            },
          );
        });
  }

  void _showContactPage({Contact contact}) async {
    final recContato = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));

    if (recContato != null) {
      if (contact != null) {
        await helper.updateContact(recContato);
      } else {
        await helper.saveContact(recContato);
      }
      _getAllContact();
    }
  }

  Widget botoesContato(text, Function acao) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: FlatButton(
        onPressed: acao,
        child: Text(
          text,
          style: TextStyle(color: Colors.red, fontSize: 20.0),
        ),
      ),
    );
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderAZ:
        setState(() {
          contatos.sort((a, b) {
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });
        });
        break;
      case OrderOptions.orderZA:
        setState(() {
          contatos.sort((a, b) {
            return b.name.toLowerCase().compareTo(a.name.toLowerCase());
          });
        });
        break;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/product_data.dart';
import 'package:lojavirtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData produto;

  ProductTile(this.type, this.produto);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(produto)));
      },
      child: Card(
        child: type == "grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    produto.images[0],
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            produto.title,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "R\$ ${produto.price.toStringAsPrecision(2)}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      produto.images[0],
                      fit: BoxFit.cover,
                      height: 250.0,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              produto.title,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "R\$ ${produto.price.toStringAsPrecision(2)}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
      ),
    );
  }
}

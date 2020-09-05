import 'package:crud_flutter/controller/product_controller.dart';
import 'package:crud_flutter/model/product.dart';
import 'package:crud_flutter/pages/product_form_page.dart';
import 'package:crud_flutter/service/product_service.dart';
import 'package:crud_flutter/util/alert.dart';
import 'package:crud_flutter/util/nav.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductListView extends StatelessWidget {
  final _controller = ProductController();
  List<Product> products;

  ProductListView(this.products);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat.currency(
        customPattern: "#,###.0##", locale: "pt_BR", decimalDigits: 2);

    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: products != null ? products.length : 0,
          itemBuilder: (context, index) {
            Product product = products[index];

            return Container(
              child: Card(
                color: Colors.grey[100],
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "R\$ ${f.format(product.price).toString()}",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      ButtonBarTheme(
                        data: ButtonBarThemeData(),
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('EDITAR'),
                              onPressed: () => {
                                push(context, ProductFormPage(product: product))
                              },
                            ),
                            FlatButton(
                              child: const Text('DELETAR'),
                              onPressed: () => _onClickDeletar(context, product),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  _onClickDeletar(context, Product p) async {
    final response = await ProductService.deleteProduct(p);

    if (response.ok) {
      alert(context, response.msg, callback: () {
        pop(context);
        _controller.getProdutos();
      });
    } else {
      alert(context, response.msg);
    }
  }
}

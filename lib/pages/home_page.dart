import 'package:crud_flutter/controller/product_controller.dart';
import 'package:crud_flutter/model/product.dart';
import 'package:crud_flutter/pages/product_form_page.dart';
import 'package:crud_flutter/util/nav.dart';
import 'package:crud_flutter/widgets/products_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = ProductController();

  @override
  void initState() {
    super.initState();

    _controller.getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 30,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          push(context, ProductFormPage());
        },
        label: Text("Adicionar Produto"),
        icon: Icon(Icons.add_shopping_cart),
      ),
    );
  }

  _body() {
    return Observer(builder: (_) {
      List<Product> products = _controller.products;

      if (_controller.error != null) {
        return Center(
          child: Text(
            "Erro ao carregar produtos.",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      if (products == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ProductListView(products),
      );
    });
  }

  Future<void> _onRefresh() {
    return _controller.getProdutos();
  }
}

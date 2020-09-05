import 'package:crud_flutter/controller/product_controller.dart';
import 'package:crud_flutter/model/product.dart';
import 'package:crud_flutter/service/product_service.dart';
import 'package:crud_flutter/util/alert.dart';
import 'package:crud_flutter/util/nav.dart';
import 'package:crud_flutter/widgets/app_button.dart';
import 'package:crud_flutter/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'home_page.dart';

class ProductFormPage extends StatefulWidget {
  Product product;

  ProductFormPage({this.product});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _controller = ProductController();

  final _formKey = GlobalKey<FormState>();
  final _tName = TextEditingController();
  final _tPrice = MoneyMaskedTextController(
      precision: 2,
      leftSymbol: 'R\$ ',
      decimalSeparator: ',',
      thousandSeparator: '.');

  var _showProgress = false;

  Product get product => widget.product;

  @override
  void initState() {
    super.initState();

    if (product != null) {
      _tName.text = product.name;
      _tPrice.text = product.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFececec),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          product != null ? product.name : "Novo Produto",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          AppText(
            "Nome",
            "Digite o nome do produto",
            icon: Icon(Icons.add_box),
            controller: _tName,
            validator: _validateName,
          ),
          AppText(
            "Preço",
            "Digite o preço do produto",
            icon: Icon(Icons.monetization_on),
            keyboardType: TextInputType.number,
            controller: _tPrice,
            validator: _validatePrice,
          ),
          SizedBox(height: 30),
          AppButton(
            "Salvar",
            showProgress: _showProgress,
            onPressed: product == null ? _onClickCadastrar : _onClickAtualizar,
          ),
        ],
      ),
    );
  }

  String _validateName(String text) {
    if (text.isEmpty) {
      return "Digite o nome do produto";
    }

    if (text.length < 3) {
      return "Nome deve ter pelo menos 3 letras";
    }
    return null;
  }

  String _validatePrice(String text) {
    if (text.isEmpty) {
      return "Digite o preço";
    }

    return null;
  }

  _onClickCadastrar() async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    setState(() {
      _showProgress = true;
    });

    Product p = Product(
      name: _tName.text,
      price: _tPrice.numberValue,
    );

    final response = await ProductService.saveProduct(p);

    setState(() {
      _showProgress = false;
    });

    if (response.ok) {
      alert(context, response.msg, callback: () {
        push(context, HomePage(), replace: true);
        _controller.getProdutos();
      });
    } else {
      alert(context, response.msg);
    }
  }

  _onClickAtualizar() async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    setState(() {
      _showProgress = true;
    });

    Product p = Product(
      id: product.id,
      name: _tName.text,
      price: _tPrice.numberValue,
    );

    final response = await ProductService.updateProduct(p);

    setState(() {
      _showProgress = false;
    });

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

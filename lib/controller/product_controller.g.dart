// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductController on ProductControllerBase, Store {
  final _$productsAtom = Atom(name: 'ProductControllerBase.products');

  @override
  List<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(List<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  final _$errorAtom = Atom(name: 'ProductControllerBase.error');

  @override
  Exception get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Exception value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$getProdutosAsyncAction =
      AsyncAction('ProductControllerBase.getProdutos');

  @override
  Future getProdutos() {
    return _$getProdutosAsyncAction.run(() => super.getProdutos());
  }

  @override
  String toString() {
    return '''
products: ${products},
error: ${error}
    ''';
  }
}

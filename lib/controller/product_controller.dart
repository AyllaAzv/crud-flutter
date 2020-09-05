import 'package:crud_flutter/model/product.dart';
import 'package:crud_flutter/service/product_service.dart';
import 'package:mobx/mobx.dart';

part 'product_controller.g.dart';

class ProductController = ProductControllerBase with _$ProductController;

abstract class ProductControllerBase with Store {

  @observable
  List<Product> products;

  @observable
  Exception error;

  @action
  getProdutos() async {
    try {
      this.products = await ProductService.findAll();
    } catch(e) {
      print(e);
    }
  }
}
import 'dart:convert' as convert;
import 'package:crud_flutter/model/api_response.dart';
import 'package:crud_flutter/model/product.dart';
import 'package:crud_flutter/util/http_helper.dart';

class ProductService {
  static final BASE_URL = "http://localhost:3001/products";

  static Future<List<Product>> findAll() async {
    var response = await get(BASE_URL);

    String json = response.body;

    List list = convert.json.decode(json);

    List<Product> products =
        list.map<Product>((map) => Product.fromMap(map)).toList();

    return products;
  }

  static Future<ApiResponse<Product>> findById(int id) async {
    try {
      var url = '$BASE_URL/$id';

      var response = await get(url);

      Map responseMap = convert.json.decode(response.body);

      if (response.statusCode == 200) {
        Product product = Product.fromMap(responseMap);

        return ApiResponse.ok(result: product);
      }

      return ApiResponse.error(msg: responseMap["error"]);
    } catch (error, exception) {
      print("Erro no busca produto $error > $exception");

      return ApiResponse.error(msg: "Não foi possível buscar produto.");
    }
  }

  static Future<ApiResponse> saveProduct(Product product) async {
    try {
      String json = product.toJson();

      var response = await post(BASE_URL, body: json);

      if (response.statusCode == 201) {
        return ApiResponse.ok(msg: "Produto salvo com sucesso.");
      }
  
      return ApiResponse.error(msg: "Não foi possível salvar o produto.");
    } catch (e) {
      print(e);

      return ApiResponse.error(msg: "Não foi possível salvar o produto.");
    }
  }

  static Future<ApiResponse> updateProduct(Product product) async {
    try {
      var url = "$BASE_URL/${product.id}";

      String json = product.toJson();

      var response = await put(url, body: json);

      if (response.statusCode == 200) {
        return ApiResponse.ok(msg: "Produto atualizado com sucesso.");
      }

      return ApiResponse.error(msg: "Não foi possível atualizar o produto.");
    } catch (e) {
      print(e);

      return ApiResponse.error(msg: "Não foi possível atualizar o produto.");
    }
  }

  static Future<ApiResponse<bool>> deleteProduct(Product p) async {
    try {
      var url = "$BASE_URL/${p.id}";

      var response = await delete(url);

      if (response.statusCode == 200) {
        return ApiResponse.ok(result: true, msg: "Produto deletado com sucesso!");
      }

      return ApiResponse.error(msg: "Não foi possível deletar este produto!");
    } catch (e) {
      return ApiResponse.error(msg: "Não foi possível deletar este produto!");
    }
  }
}

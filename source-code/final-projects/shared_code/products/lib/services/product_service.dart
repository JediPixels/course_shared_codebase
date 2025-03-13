import 'dart:async';

import 'package:flutter/material.dart';
import 'package:products/models/product_model.dart';
import 'package:shared/shared.dart';
import 'package:products/helpers/api_url.dart';

class ProductService {
  ProductService() {
    clearProductList();
  }

  final StreamController<List<Product>> _productListController =
      StreamController<List<Product>>();
  Sink<List<Product>> get _addProductList => _productListController.sink;
  Stream<List<Product>> get productListStream => _productListController.stream;
  final List<Product> _productList = <Product>[];

  void dispose() {
    _productListController.close();
  }

  void _addProduct(List<Product> addToProductList) {
    // Add Topics to the existing Product List
    _productList.addAll(addToProductList);
    _addProductList.add(addToProductList);
  }

  void refreshCurrentListTopics() {
    _addProductList.add(_productList);
  }

  void clearProductList() {
    List<Product> emptyList = <Product>[];
    _addProduct(emptyList);
  }

  Future<List<Product>> getProductsList() async {
    final String resultsBody =
        await APIService.getSearch(ApiUrl.apiBaseAndQueryUrl);
    final List<Product> results =
        ProductModel.fromRawJson(resultsBody).products;

    if (results.isEmpty) {
      debugPrint('Error Code: $results}');
    }

    _addProduct(results);
    return results;
  }
}

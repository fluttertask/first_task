import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_task/Src/Constants/uri.dart';
import 'package:flutter_task/Src/Models/Product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState(state: false, product: null)) {
    dio = Dio();
  }

  late Dio dio;

  Future addProduct(Product product) async {
    dio.post(
      CustomUrl().addProduct,
      data: product.toJson()
      ).then(
      (response) {
        final List<Map<String, dynamic>> data = json.decode(response.data as String) as List<Map<String, dynamic>>;
        final List<Product> products = data.map((e) => Product.fromMap(json.decode(response.data as String) as Map<String, dynamic>)).toList();

        return emit(ProductState(state: true, product: products));
      }
    ).catchError(
      (err) {
        return emit(ProductState(state: false, product: null));
      }
    );
  }

  Future getProduct() async {
    dio.get(CustomUrl().getProduct).then(
      (response) {
        final List<Map<String, dynamic>> data = json.decode(response.data as String) as List<Map<String, dynamic>>;
        final List<Product> products = data.map((e) => Product.fromMap(json.decode(response.data as String) as Map<String, dynamic>)).toList();

        return emit(ProductState(state: true, product: products));
      }
    ).catchError(
      (err) {
        return emit(ProductState(state: false, product: null));
      }
    );
  }
}

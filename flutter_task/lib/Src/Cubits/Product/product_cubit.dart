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
    final FormData productForm = await product.toForm();
    dio.post(
      CustomUrl().addProduct,
      data: productForm
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

  Future updateProduct(Product product) async {
    final FormData productForm = await product.toForm();

    dio.post(
      CustomUrl().updateProduct,
      data: productForm
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

  Future checkNetwork() async {
    dio.get(CustomUrl().networkTest).asStream().asBroadcastStream().listen(
      (event) { }
    ).onError(
      (err) { }
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
    ).onError(
      (error, stackTrace) {
        return emit(ProductState(state: false, product: null));
      });
  }
}

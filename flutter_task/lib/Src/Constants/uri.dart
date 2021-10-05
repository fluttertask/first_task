const _baseUrl = 'http://localhost:3000';

class CustomUrl{
  final addProduct = '$_baseUrl/api/addProduct';
  final getProduct = '$_baseUrl/api/getProduct';
  final updateProduct = '$_baseUrl/api/addProduct';
  final networkTest = '$_baseUrl/test';

  String imageUrl (String name) {
    return '$_baseUrl/images/$name';
  }
}
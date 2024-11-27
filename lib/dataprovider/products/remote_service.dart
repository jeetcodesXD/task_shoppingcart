import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/helper/data_state.dart';
import '../models/product.dart';

class ProductDataSource {
  final String apiUrl = 'https://dummyjson.com/products';

  Future<DataState<List<Product>, InternetError>> getProducts(
      int page, int limit) async {
    try {
      final response = await http
          .get(Uri.parse('$apiUrl?skip=${(page - 1) * limit}&limit=$limit'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['products'] as List;
        final products = data.map((e) => Product.fromJson(e)).toList();
        return DataSuccess(data: products);
      } else {
        return DataFailed(
          error: InternetError(errorMsg: 'Failed to fetch products from API.'),
        );
      }
    } catch (e) {
      return DataFailed(
        error: InternetError(
            errorMsg: 'Failed to fetch products from API.', error: e),
      );
    }
  }
}

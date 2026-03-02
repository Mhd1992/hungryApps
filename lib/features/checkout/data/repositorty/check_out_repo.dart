import 'package:hungry/core/utils/exported_file.dart';

import '../../../../update_features/cart/cart/items/item_model.dart'
    show CartRequest;

class CheckoutRepo {
  CheckoutRepo._internal();
  static final CheckoutRepo _instance = CheckoutRepo._internal();
  factory CheckoutRepo() => _instance;
  final ApiService _apiService = ApiService(DioClient().dio);
  Future<String> checkout(CartRequest cartModel) async {
    try {
      final response = await _apiService.checkOut(cartModel);
      if (response is ApiError) {
        throw response;
      }
      if (response.code == 200 || response.code == 201) {
        return response.message;
      }
    } on DioException catch (error) {
      throw ApiException.handleError(error);
    } catch (error) {
      throw ApiError(message: error.toString());
    }
    throw ApiError(message: 'Unknown error occurred addToCart.');
  }
}

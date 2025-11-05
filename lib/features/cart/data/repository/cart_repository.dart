import 'package:hungry/core/networks/retrofit/model/cart/items/item_model.dart';
import 'package:hungry/core/utils/exported_file.dart';

class CartRepo {
  CartRepo._internal();
  static final CartRepo _instance = CartRepo._internal();
  factory CartRepo() => _instance;

  final ApiService _apiService = ApiService(DioClient().dio);

  Future<String> addToCart(CartRequest cartModel) async {
    try {
      final response = await _apiService.addToCaret(cartModel);

      if (response is ApiError) {
        throw response;
      }
      if (response.code == 200) {
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

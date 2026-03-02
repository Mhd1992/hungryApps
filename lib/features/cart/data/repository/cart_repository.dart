import 'package:hungry/core/utils/exported_file.dart';

import '../../../../update_features/cart/cart/items/item_model.dart';
import '../../../../update_features/cart/cart/request_cart/cart_item_model.dart';

class CartRepo {
  CartRepo._internal();
  static final CartRepo _instance = CartRepo._internal();
  factory CartRepo() => _instance;
  CartItemModel? get cachedCartItem => _cachedCartItem;
  final ApiService _apiService = ApiService(DioClient().dio);
  CartItemModel? _cachedCartItem;

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

  Future<void> resetItem() async {
    _cachedCartItem = null;
  }

  Future<CartItemModel?> getCartItem() async {
    try {
      if (_cachedCartItem != null) {
        return _cachedCartItem;
      }
      final response = await _apiService.getCartItem();

      if (response is ApiError) {
        throw response;
      }
      if (response.code == 200) {
        final cartItem = response.data;
        _cachedCartItem = cartItem;
        return cartItem;
      }
    } on DioException catch (error) {
      throw ApiException.handleError(error);
    } catch (error) {
      throw ApiError(message: error.toString());
    }
    throw ApiError(message: 'Unknown error occurred getCartItem.');
  }

  Future<String> removeFromCart(int cartId) async {
    try {
      final response = await _apiService.removeFromCart(cartId);
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
    throw ApiError(message: 'Unknown error occurred getCartItem.');
  }
}

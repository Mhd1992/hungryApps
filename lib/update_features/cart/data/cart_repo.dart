import 'package:hungry/core/base/base_repo.dart';
import 'package:hungry/update_features/cart/cart/items/item_model.dart';
import 'package:hungry/update_features/cart/data/cart_api.dart';

import '../cart/request_cart/cart_item_model.dart';

class CartRepo extends BaseRepo {
  final CartApi _api;
  CartRepo(this._api);

  Future<CartItemModel> loadCartItem() async {
    return runData(() => _api.loadCartItem());
  }

  Future<CartItemModel?> addToCartItem(CartRequest request) async {
    return runOptional(() => _api.addToCaretItem(request));
  }

  Future<CartItemModel?> removeCartItem(int id) async {
    return runOptional(() => _api.removeFromCartItem(id));
  }
}

import 'package:hungry/core/base/base_repo.dart';

import 'package:hungry/update_features/cart/cart/items/item_model.dart';

import '../../../../core/networks/retrofit/model/base_response.dart';
import '../../cart/request_cart/cart_item_model.dart';
import '../network/cart_api.dart';

class CartRepo extends BaseRepo {
  final CartApi _api;
  CartRepo(this._api);

  Future<CartItemModel> loadCartItem() async {
    return loadData(() => _api.loadCartItem());
  }

  Future<CartItemModel?> addToCartItem(CartRequest request) async {
    return loadOptionalData(() => _api.addToCaretItem(request));
  }

  Future<BaseResponse<String?>> removeCartItem(int id) async {
    return runAction(() => _api.removeFromCartItem(id));
  }
}

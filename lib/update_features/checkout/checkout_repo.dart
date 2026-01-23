import 'package:hungry/core/base/base_repo.dart';
import 'package:hungry/update_features/checkout/checkout_api.dart';
import '../cart/cart/items/item_model.dart';
import '../cart/cart/request_cart/cart_item_model.dart';
import 'checkout_model.dart';
import 'model/orders/created_order_model.dart';

class CheckoutRepo extends BaseRepo {
  final CheckoutApi _api;

  CheckoutRepo(this._api);

  Future<CreatedOrderModel> saveOrder(CartRequest checkOutRequest) async {
    print('');
    return runData(() => _api.saveOrder(checkOutRequest));
  }
}

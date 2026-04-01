import 'package:hungry/core/base/base_repo.dart';
import 'package:hungry/update_features/checkout/data/checkout_api.dart';
import '../../cart/cart/items/item_model.dart';
import '../../cart/cart/request_cart/cart_item_model.dart';
import 'checkout_model.dart';
import '../model/order_item/item_detail_model.dart';
import '../model/orders/created_order_model.dart';
import '../model/orders/order_model.dart';

class CheckoutRepo extends BaseRepo {
  final CheckoutApi _api;

  CheckoutRepo(this._api);

  Future<CreatedOrderModel> saveOrder(CartRequest checkOutRequest) async {
    return loadData(() => _api.saveOrder(checkOutRequest));
  }

  Future<ItemDetailModel> getOrder(int id) async {
    return loadData(() => _api.getOrder(id));
  }

  Future<List<OrderModel>> getOrders() async {
    return loadData(() => _api.getOrders());
  }
}

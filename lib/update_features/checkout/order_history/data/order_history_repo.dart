import 'package:hungry/core/base/base_repo.dart';

import '../../data/network/checkout_api.dart';
import '../../model/orders/order_model.dart';

class OrderHistoryRepo extends BaseRepo {
  final CheckoutApi _api;

  OrderHistoryRepo(this._api);

  Future<List<OrderModel>> getOrders() async {
    return loadData(() => _api.getOrders());
  }
}

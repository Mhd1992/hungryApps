import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/update_features/checkout/data/checkout_provider.dart';

import '../../../../core/base/base_controller.dart';
import '../../model/orders/order_model.dart';

final orderHistoryControllerProvider =
    StateNotifierProvider<
      OrderHistoryController,
      AsyncValue<List<OrderModel>?>
    >((ref) => OrderHistoryController(ref));

class OrderHistoryController extends BaseController<List<OrderModel>> {
  Ref ref;

  OrderHistoryController(this.ref);

  Future<void> getOrders() async {
    final repo = ref.read(checkoutRepoProvider);
    loadOnce(() => repo.getOrders());
  }
}

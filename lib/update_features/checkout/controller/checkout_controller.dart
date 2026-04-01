import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/update_features/checkout/data/provider/checkout_provider.dart';
import 'package:hungry/update_features/checkout/model/orders/created_order_model.dart';
import '../../../core/base/base_controller.dart';
import '../../cart/cart/items/item_model.dart';

final checkoutControllerProvider =
    StateNotifierProvider<CheckoutController, AsyncValue<CreatedOrderModel?>>(
      (ref) => CheckoutController(ref),
    );

class CheckoutController extends BaseController<CreatedOrderModel> {
  Ref ref;
  CheckoutController(this.ref);
  Future<void> saveOrder(CartRequest checkoutModel) async {
    final repo = ref.read(checkoutRepoProvider);
    loadOnce(() => repo.saveOrder(checkoutModel));
  }
}

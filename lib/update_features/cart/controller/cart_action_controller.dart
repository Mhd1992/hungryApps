import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/base/base_controller.dart';
import 'package:hungry/update_features/cart/data/cart_provider.dart';

import 'cart_controller.dart';

final cartActionControllerProvider =
    StateNotifierProvider<CartActionController, AsyncValue<String?>>(
      (ref) => CartActionController(ref),
    );

class CartActionController extends BaseController<String?> {
  Ref ref;

  CartActionController(this.ref);

  Future<void> removeFromCartItem(int id) async {
    final repo = ref.read(cartRepoProvider);

    final message = await requestAction(
      () => repo.removeCartItem(id),
      (response) => response.message ?? "Item removed",
    );

    await ref
        .read(cartControllerProvider.notifier)
        .loadCartItem(useCache: false);
    // return message ?? "Item removed";
  }
}

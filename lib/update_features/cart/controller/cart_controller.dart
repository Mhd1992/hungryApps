import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/core/base/base_controller.dart';
import 'package:hungry/update_features/cart/data/cart_provider.dart';

import '../cart/items/item_model.dart';
import '../cart/request_cart/cart_item_model.dart';

final cartControllerProvider =
    StateNotifierProvider<CartController, AsyncValue<CartItemModel?>>(
      (ref) => CartController(ref),
    );

class CartController extends BaseController<CartItemModel?> {
  Ref ref;

  CartController(this.ref);

  Future<void> loadCartItem({bool useCache = true}) async {
    final repo = ref.read(cartRepoProvider);
    await loadOnce(() => repo.loadCartItem(), useCache: useCache);
  }

  void addToCartItem(CartRequest req) {
    final repo = ref.read(cartRepoProvider);
    request(() => repo.addToCartItem(req));
  }

  Future<void> removeFromCartItem(int id) async {
    final repo = ref.read(cartRepoProvider);
    await request(() => repo.removeCartItem(id)).then((_) {
      loadCartItem(useCache: false);
    });
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/features/cart/data/repository/cart_repository.dart';

import '../../../update_features/cart/cart/request_cart/cart_item_model.dart';

final cartControllerProvider =
    StateNotifierProvider<CartController, AsyncValue<CartItemModel?>>(
      (ref) => CartController(CartRepo()),
    );

class CartController extends StateNotifier<AsyncValue<CartItemModel?>> {
  CartController(this._repo) : super(const AsyncLoading()) {
    loadCartItems();
  }

  final CartRepo _repo;

  Future<void> loadCartItems() async {
    state = const AsyncLoading();
    try {
      final cart = await _repo.getCartItem();
      state = AsyncData(cart);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<String?> removeCartItem(int cartId) async {
    state = const AsyncLoading();
    try {
      final result = await _repo.removeFromCart(cartId); // result is String ✅
      await loadCartItems(); // refresh cart
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/update_features/cart/controller/cart_action_controller.dart';

import '../cart/request_cart/cart_item_model.dart';
import 'cart_controller.dart';

final cartScreenProvider = Provider<AsyncValue<CartScreenState>>((ref) {
  final cartState = ref.watch(cartControllerProvider);
  final cartAction = ref.watch(cartActionControllerProvider);

  if (cartState.isLoading || cartAction.isLoading) {
    return const AsyncLoading();
  }

  if (cartState.hasError) {
    return AsyncError(cartState.error!, cartState.stackTrace!);
  }

  if (cartAction.hasError) {
    return AsyncError(cartAction.error!, cartAction.stackTrace!);
  }

  return AsyncData(CartScreenState(cartItemModel: cartState.value));
});

class CartScreenState {
  final CartItemModel? cartItemModel;

  CartScreenState({required this.cartItemModel});
}

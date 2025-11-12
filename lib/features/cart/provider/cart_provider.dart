import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/core/networks/retrofit/model/cart/request_cart/cart_item_model.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/cart/data/repository/cart_repository.dart';

final cartProvider = StateProvider<AsyncValue<CartItemModel?>>(
  (ref) => const AsyncValue.loading(),
);
final quantityProvider = StateProvider<int>((ref) => 1);

final quantitiesProvider = StateProvider<List<int>>((ref) => []);

final cartRepo = CartRepo();

Future<void> loadCartItems({required WidgetRef ref}) async {
  try {
    ref.read(cartProvider.notifier).state = const AsyncValue.loading();

    final cart = await cartRepo.getCartItem();

    final initialQuantities = List<int>.filled(cart!.items.length, 1);
    ref.read(quantitiesProvider.notifier).state = initialQuantities;

    ref.read(cartProvider.notifier).state = AsyncValue.data(cart);
  } catch (e) {
    ref.read(cartProvider.notifier).state = AsyncValue.error(
      e.toString(),
      StackTrace.current,
    );
  }
}

final removeLoadingProvider = StateProvider<bool>((ref) => false);

Future<void> removeCartItem<T, P>({
  required Future<T> Function(P param) apiCall,
  required P param,
  required void Function(T) onSuccess,
}) async {
  try {
    final result = await apiCall(param);
    if (result != null) {
      onSuccess(result);
    }
  } catch (e) {
    String errorMessage = 'Unknown error';
    if (e is ApiError) {
      errorMessage = e.message;
    }
  } finally {}
}

Future<String?> removeItem({
  required WidgetRef ref,
  required int itemId,
}) async {
  String? message;

  try {
    ref.read(removeLoadingProvider.notifier).state = true;

    final result = await cartRepo.removeFromCart(itemId);

    final currentState = ref.read(cartProvider);
    if (currentState.hasValue && currentState.value != null) {
      final cart = currentState.value!;
      final updatedItems = cart.items
          .where((item) => item.itemId != itemId)
          .toList();

      final updatedCart = CartItemModel(updatedItems, cart.id, cart.totalPrice);
      ref.read(cartProvider.notifier).state = AsyncValue.data(updatedCart);
    }

    message = result;
    //message = "Item removed successfully ✅";
  } catch (e, st) {
    ref.read(cartProvider.notifier).state = AsyncValue.error(e.toString(), st);
    message = "Failed to remove item";
  } finally {
    ref.read(removeLoadingProvider.notifier).state = false;
  }

  return message;
}

void showMessage(String message, BuildContext context, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.yellow.shade700,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

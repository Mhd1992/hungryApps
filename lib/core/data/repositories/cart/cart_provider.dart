import 'package:hungry/core/data/base_controller.dart';
import 'package:hungry/core/networks/retrofit/model/cart/request_cart/cart_item_model.dart';
import 'package:hungry/core/utils/exported_file.dart';

import 'cart_repo_provider.dart';

final cartRepoProvider = Provider<CartRepoProvider>((ref) {
  return CartRepoProvider(ref);
});

// to handle UI state
final cartControllerProvider =
    StateNotifierProvider<
      BaseController<CartItemModel>,
      AsyncValue<CartItemModel>
    >((ref) => BaseController<CartItemModel>(ref.read(cartRepoProvider)));

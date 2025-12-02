import 'package:hungry/core/data/base_repo.dart';
import 'package:hungry/core/networks/retrofit/model/cart/request_cart/cart_item_model.dart';

import '../../../utils/exported_file.dart';

final cartProviderV1 = StateProvider<AsyncValue<CartItemModel?>>(
  (ref) => const AsyncValue.loading(),
);

final quantitiesProviderV1 = StateProvider<List<int>>((ref) => []);

class CartRepoProvider extends BaseRepo<CartItemModel> {
  CartRepoProvider._internal(super.ref);

  factory CartRepoProvider(Ref ref) {
    return CartRepoProvider._internal(ref);
  }

  final ApiService _apiService = ApiService(DioClient().dio);

  Future<void> fetchCartItem({required WidgetRef ref}) async {
    await handleRequest<CartItemModel>(
      apiCall: _apiService.getCartItem,
      onSuccess: (result) {
        ref.read(cartProviderV1.notifier).state = AsyncValue.data(result);
        final initialQuantity = List<int>.filled(result.items.length, 1);
        ref.read(quantitiesProviderV1.notifier).state = initialQuantity;
      },
    );
  }

  Future<void> removeCartItem(int cartId, {required WidgetRef ref}) async {
    await handleRequestWithParam<String, int>(
      apiCall: _apiService.removeFromCart,
      param: cartId,
      onSuccess: (data) async {
        ref.context.showSnackBar(data);
        await fetchCartItem(ref: ref);
      },
    );
  }

  @override
  void setLoadingState(bool value) {
    // add your loading logic
  }
}

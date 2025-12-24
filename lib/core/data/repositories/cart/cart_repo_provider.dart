import 'package:hungry/core/data/base_repo.dart';
import 'package:hungry/core/networks/retrofit/model/cart/items/item_model.dart';
import 'package:hungry/core/networks/retrofit/model/cart/request_cart/cart_item_model.dart';

import '../../../utils/exported_file.dart';

final cartProviderV1 = StateProvider<AsyncValue<CartItemModel?>>(
  (ref) => const AsyncValue.loading(),
);

final quantitiesProviderV1 = StateProvider<List<int>>((ref) => []);

final selectedOptionProvider = StateProvider.autoDispose<Set<int>>((ref) => {});
final selectedToppingProvider = StateProvider.autoDispose<Set<int>>(
  (ref) => {},
);

final loading = StateProvider((ref) => false);

class CartRepoProvider extends BaseRepo<CartItemModel> {
  CartRepoProvider._internal(super.ref);

  factory CartRepoProvider(Ref ref) {
    return CartRepoProvider._internal(ref);
  }

  final ApiService _apiService = ApiService(DioClient().dio);

  Future<void> addToCart(CartRequest request, {required WidgetRef ref}) async {
    ref.read(loading.notifier).state = true;
    await handleRequestWithParam<BaseResponse<dynamic>, CartRequest>(
      apiCall: _apiService.addToCaret,
      param: request,
      onSuccess: (success) {
        ref.read(loading.notifier).state = false;
        ref.context.showSnackBar(success.message);
      },
    );
  }

  Future<CartItemModel?> fetchCartItem({required WidgetRef ref}) async {
    //Future<void> fetchCartItem({required WidgetRef ref}) async {
    CartItemModel? cartItemModel;

    await handleRequest<CartItemModel>(
      apiCall: _apiService.getCartItem,
      onSuccess: (result) {
        ref.read(cartProviderV1.notifier).state = AsyncValue.data(result);
        cartItemModel = result;
        final initialQuantity = List<int>.filled(result.items.length, 1);
        ref.read(quantitiesProviderV1.notifier).state = initialQuantity;
      },
    );
    return cartItemModel;
  }

  Future<void> removeCartItem(int cartId, {required WidgetRef ref}) async {
    await handleRequestWithParam<BaseResponse<String>, int>(
      apiCall: _apiService.removeFromCart,
      param: cartId,
      onSuccess: (data) async {
        final msg = data.copyWith(msg: data.message);
        ref.context.showSnackBar(msg.message);
        await fetchCartItem(ref: ref);
      },
    );
  }
}

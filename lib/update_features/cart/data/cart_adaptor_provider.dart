import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cart/request_cart/cart_item_model.dart';
import '../controller/cart_controller.dart';
import 'package:hungry/core/networks/retrofit/model/base_response.dart';

final cartAdaptorProvider = Provider<AsyncValue<BaseResponse<CartItemModel>>>((
  ref,
) {
  final state = ref.watch(cartControllerProvider);

  return state.when(
    loading: () => const AsyncLoading(),
    data: (data) => AsyncData(
      BaseResponse<CartItemModel>(code: 200, message: 'Success', data: data),
    ),
    error: (error, stack) => AsyncError(error, stack),
  );
});

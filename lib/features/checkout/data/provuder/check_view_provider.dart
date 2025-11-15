import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/core/networks/retrofit/model/cart/items/item_model.dart';
import 'package:hungry/features/checkout/data/repositorty/check_out_repo.dart';

final checkViewProvider = StateProvider.autoDispose<AsyncValue<String>>(
  (ref) => AsyncValue.loading(),
);

Future<void> checkoutV1(CartRequest cartModel, {required WidgetRef ref}) async {
  final CheckoutRepo checkoutRepo = CheckoutRepo();
  ref.read(checkViewProvider.notifier).state = const AsyncValue.loading();
  try {
    final checkout = await checkoutRepo.checkout(cartModel);
    ref.read(checkViewProvider.notifier).state = AsyncValue.data(checkout);
  } catch (e) {
    ref.read(checkViewProvider.notifier).state = AsyncValue.error(
      e.toString(),
      StackTrace.current,
    );
  }
}

/***?
 *
 *
    final checkViewProvider = StateProvider.autoDispose<String>((ref) => "");

    Future<void> checkout(CartRequest cartModel,{required WidgetRef ref}) async {
    final CheckoutRepo checkoutRepo = CheckoutRepo();
    //ref.read(checkViewProvider.notifier).state = const AsyncValue.loading();
    try{
    final checkout = await checkoutRepo.checkout(cartModel);

    }catch(e){
    ref.read(checkViewProvider.notifier).state = AsyncValue.error(
    e.toString(),
    StackTrace.current,
    );
    }


    }

 */

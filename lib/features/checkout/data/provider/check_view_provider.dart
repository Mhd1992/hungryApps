import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/networks/retrofit/model/cart/items/item_model.dart';
import 'package:hungry/features/auth/data/repository/v1/auth_repo_v1.dart';
import 'package:hungry/features/checkout/data/repositorty/check_out_repo.dart';
import 'package:hungry/features/checkout/view/enum/payment_type.dart';

final checkViewProvider = StateProvider.autoDispose<AsyncValue<String>>(
  (ref) => AsyncValue.loading(),
);

final AuthRepoV1 authRepoV1 = AuthRepoV1();

final guestProvider = StateProvider.autoDispose<bool>(
  (ref) => authRepoV1.isGuest,
);

final visaProvider = StateProvider.autoDispose<bool>(
  (ref) => authRepoV1.cachedUser?.visa == null,
);

final paymentTypeProvider = StateProvider.autoDispose<PaymentType>(
  (ref) => PaymentType.cash,
);

final checkedProvider = StateProvider.autoDispose<bool>((ref) => false);

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

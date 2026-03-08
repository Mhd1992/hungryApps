import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/update_features/products/product_details/side_option/controller/side_option_controller.dart';
import 'package:hungry/update_features/products/product_details/side_option/data/side_option_model.dart';
import 'package:hungry/update_features/products/product_details/topping/controller/topping_controller.dart';
import 'package:hungry/update_features/products/product_details/topping/data/topping_model.dart';

final productDetailScreenProvider = Provider<AsyncValue<ProductDetailState>>((
  ref,
) {
  final toppings = ref.watch(toppingControllerProvider);
  final sideOptions = ref.watch(sideOptionControllerProvider);
  if (toppings.isLoading || sideOptions.isLoading) {
    return AsyncLoading();
  }

  if (toppings.hasError) {
    return AsyncError(toppings.error!, toppings.stackTrace!);
  }

  if (sideOptions.hasError) {
    return AsyncError(sideOptions.error!, sideOptions.stackTrace!);
  }

  return AsyncData(
    ProductDetailState(
      toppings: toppings.value ?? [],
      sideOptions: sideOptions.value ?? [],
    ),
  );
});

class ProductDetailState {
  final List<ToppingModel> toppings;
  final List<SideOptionModel> sideOptions;

  ProductDetailState({required this.toppings, required this.sideOptions});
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/update_features/home/products/controller/product_controller.dart';
import 'package:hungry/update_features/home/products/data/product_model.dart';

import 'categories/controller/category_controller.dart';
import 'categories/data/category_model.dart';

final homeCombinedProvider = Provider<AsyncValue<HomeState>>((ref) {
  final categoryState = ref.watch(categoryControllerProvider);
  final productState = ref.watch(productControllerProvider);

  /// Loading
  if (categoryState.isLoading || productState.isLoading) {
    return const AsyncLoading();
  }

  /// Error
  if (categoryState.hasError) {
    return AsyncError(categoryState.error!, categoryState.stackTrace!);
  }

  if (productState.hasError) {
    return AsyncError(productState.error!, productState.stackTrace!);
  }

  /// Data ready
  return AsyncData(
    HomeState(
      categories: categoryState.value ?? [],
      products: productState.value ?? [],
    ),
  );
});

class HomeState {
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  HomeState({required this.categories, required this.products});
}

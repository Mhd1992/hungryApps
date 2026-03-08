import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/networks/dio_provider.dart';
import 'package:hungry/update_features/products/product_details/topping/data/topping_api.dart';
import 'package:hungry/update_features/products/product_details/topping/data/topping_repo.dart';

final toppingApiProvider = Provider<ToppingApi>((ref) {
  final dio = ref.read(dioProvider);
  return ToppingApi(dio);
});

final toppingRepoProvider = Provider<ToppingRepo>((ref) {
  final api = ref.read(toppingApiProvider);
  return ToppingRepo(api);
});

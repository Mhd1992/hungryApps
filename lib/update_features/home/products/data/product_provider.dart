import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/networks/dio_provider.dart';
import 'package:hungry/update_features/home/products/data/product_api.dart';
import 'package:hungry/update_features/home/products/data/product_repo.dart';

final productApiProvider = Provider<ProductApi>((ref) {
  final dio = ref.read(dioProvider);
  return ProductApi(dio);
});

final productRepoProvider = Provider<ProductRepo>((ref) {
  final api = ref.read(productApiProvider);
  return ProductRepo(api);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/networks/dio_provider.dart';
import 'package:hungry/update_features/cart/data/repo/cart_repo.dart';

import '../network/cart_api.dart';

final cartApiProvider = Provider<CartApi>((ref) {
  final dio = ref.read(dioProvider);
  return CartApi(dio);
});

final cartRepoProvider = Provider<CartRepo>((ref) {
  final api = ref.read(cartApiProvider);
  return CartRepo(api);
});

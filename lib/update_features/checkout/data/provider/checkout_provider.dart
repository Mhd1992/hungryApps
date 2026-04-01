import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/networks/dio_provider.dart';
import 'package:hungry/update_features/checkout/data/network/checkout_api.dart';
import 'package:hungry/update_features/checkout/data/repo/checkout_repo.dart';

final checkoutApiProvider = Provider<CheckoutApi>((ref) {
  final dio = ref.read(dioProvider);
  return CheckoutApi(dio);
});

final checkoutRepoProvider = Provider<CheckoutRepo>((ref) {
  final api = ref.read(checkoutApiProvider);
  return CheckoutRepo(api);
});

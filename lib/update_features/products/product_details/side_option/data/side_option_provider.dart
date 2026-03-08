import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/networks/dio_provider.dart';
import 'package:hungry/update_features/products/product_details/side_option/data/side_option_api.dart';
import 'package:hungry/update_features/products/product_details/side_option/data/side_option_repo.dart';

final sideOptionApiProvider = Provider<SideOptionApi>((ref) {
  final dio = ref.read(dioProvider);
  return SideOptionApi(dio);
});

final sideOptionRepoProvider = Provider<SideOptionRepo>((ref) {
  final api = ref.read(sideOptionApiProvider);
  return SideOptionRepo(api);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/update_features/home/categories/data/category_repo.dart';

import '../../../../core/networks/dio_provider.dart';
import 'category_api.dart';

final categoryApiProvider = Provider<CategoryApi>((ref) {
  final dio = ref.read(dioProvider);
  return CategoryApi(dio);
});

final categoryRepoProvider = Provider<CategoryRepo>((ref) {
  final api = ref.read(categoryApiProvider);
  return CategoryRepo(api);
});

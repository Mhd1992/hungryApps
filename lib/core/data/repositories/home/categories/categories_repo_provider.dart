import 'package:hungry/core/data/base_repo.dart';

import '../../../../utils/exported_file.dart';

final categoriesProvider = StateProvider<AsyncValue<List<CategoryModel>>>(
  (ref) => const AsyncValue.loading(),
);

class CategoriesRepoProvider extends BaseRepo<List<CategoryModel>> {
  CategoriesRepoProvider._internal(super.ref);

  factory CategoriesRepoProvider(Ref ref) {
    return CategoriesRepoProvider._internal(ref);
  }
  final ApiService _apiService = ApiService(DioClient().dio);

  List<CategoryModel>? cachedData;
  Future<List<CategoryModel>> fetchCategories({required WidgetRef ref}) async {
    if (cachedData != null && cachedData!.isNotEmpty) {
      ref.read(categoriesProvider.notifier).state = AsyncValue.data(
        cachedData!,
      );
    }
    await handleRequest<List<CategoryModel>>(
      apiCall: _apiService.getCategories,
      onSuccess: (result) {
        cachedData = result;
        ref.read(categoriesProvider.notifier).state = AsyncValue.data(result);
      },
    );
    return cachedData ?? [];
  }
}

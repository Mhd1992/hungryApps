import 'package:hungry/core/data/base_repo.dart';

import 'package:hungry/core/utils/exported_file.dart';

final _productsProvider = StateProvider<AsyncValue<List<ProductModel>>>(
  (ref) => const AsyncValue.loading(),
);

class ProductsRepoProvider extends BaseRepo<List<ProductModel>> {
  ProductsRepoProvider._internal(super.ref);

  factory ProductsRepoProvider(Ref ref) {
    return ProductsRepoProvider._internal(ref);
  }
  final ApiService _apiService = ApiService(DioClient().dio);
  List<ProductModel>? cachedData;
  Future<void> fetchProducts({required WidgetRef ref}) async {
    if (cachedData != null && cachedData!.isNotEmpty) {
      ref.read(_productsProvider.notifier).state = AsyncValue.data(cachedData!);
      return;
    }
    await handleRequest<List<ProductModel>>(
      apiCall: _apiService.getProducts,
      onSuccess: (result) {
        cachedData = result;
        //ref.read(_productsProvider.notifier).state = AsyncValue.data(result);
      },
    );
  }
}

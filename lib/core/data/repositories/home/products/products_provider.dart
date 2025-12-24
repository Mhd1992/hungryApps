import 'package:hungry/core/data/base_controller.dart';
import 'package:hungry/core/data/repositories/home/products/products_repo_provider.dart';
import 'package:hungry/core/utils/exported_file.dart';

final productProvider = Provider<ProductsRepoProvider>((ref) {
  return ProductsRepoProvider(ref);
});

final productControllerProvider =
    StateNotifierProvider<
      BaseController<List<ProductModel>>,
      AsyncValue<List<ProductModel>>
    >((ref) => BaseController<List<ProductModel>>(ref.read(productProvider)));

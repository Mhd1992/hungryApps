import 'package:hungry/core/data/repositories/home/products/products_repo_provider.dart';
import 'package:hungry/core/utils/exported_file.dart';

final productProvider = Provider<ProductsRepoProvider>((ref) {
  return ProductsRepoProvider(ref);
});

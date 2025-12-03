import 'package:hungry/core/utils/exported_file.dart';
import 'categories_repo_provider.dart';

final categoriesProvider = Provider<CategoriesRepoProvider>((ref) {
  return CategoriesRepoProvider(ref);
});

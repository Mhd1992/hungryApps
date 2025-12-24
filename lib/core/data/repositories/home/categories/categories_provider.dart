import 'package:hungry/core/data/base_controller.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'categories_repo_provider.dart';

final categoriesProvider = Provider<CategoriesRepoProvider>((ref) {
  return CategoriesRepoProvider(ref);
});

final categoryControllerProvider =
    StateNotifierProvider<
      BaseController<List<CategoryModel>>,
      AsyncValue<List<CategoryModel>>
    >(
      (ref) =>
          BaseController<List<CategoryModel>>(ref.read(categoriesProvider)),
    );

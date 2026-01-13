import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/core/base/base_controller.dart';
import 'package:hungry/update_features/home/categories/data/category_provider.dart';
import '../data/category_model.dart';

final categoryControllerProvider =
    StateNotifierProvider<CategoryController, AsyncValue<List<CategoryModel>?>>(
      (ref) => CategoryController(ref),
    );

class CategoryController extends BaseController<List<CategoryModel>?> {
  Ref ref;
  CategoryController(this.ref);

  void getAllCategories() async {
    final repo = ref.read(categoryRepoProvider);
    await loadOnce(() => repo.getAllCategory());
  }
}

import 'package:hungry/core/base/base_repo.dart';

import 'category_api.dart';
import 'category_model.dart';

class CategoryRepo extends BaseRepo {
  final CategoryApi _api;

  CategoryRepo(this._api);

  Future<List<CategoryModel>> getAllCategory() async {
    return runData(() => _api.getCategories());
  }
}

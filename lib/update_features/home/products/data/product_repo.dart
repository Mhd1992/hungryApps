import 'package:hungry/update_features/home/products/data/product_api.dart';
import 'package:hungry/update_features/home/products/data/product_model.dart';

import '../../../../core/base/base_repo.dart';

class ProductRepo extends BaseRepo {
  final ProductApi _api;

  ProductRepo(this._api);

  Future<List<ProductModel>> getAllProducts() async {
    return loadData(() => _api.getProducts());
  }
}

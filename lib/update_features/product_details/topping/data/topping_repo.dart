import 'package:hungry/core/base/base_repo.dart';
import 'package:hungry/update_features/product_details/topping/data/topping_api.dart';
import 'package:hungry/update_features/product_details/topping/data/topping_model.dart';

class ToppingRepo extends BaseRepo {
  final ToppingApi _api;

  ToppingRepo(this._api);

  Future<List<ToppingModel>> loadTopping() async {
    return loadData(() => _api.loadToppings());
  }

  Future<ToppingModel> getTopping(int toppingId) async {
    return loadData(() => _api.getTopping(toppingId));
  }
}

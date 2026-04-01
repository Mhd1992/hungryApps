import 'package:hungry/core/base/base_repo.dart';

import '../../data/network/checkout_api.dart';
import '../../model/order_item/item_detail_model.dart';

class ItemDetailRepo extends BaseRepo {
  final CheckoutApi _api;

  ItemDetailRepo(this._api);

  Future<ItemDetailModel> getOrder(int id) async {
    return loadData(() => _api.getOrder(id));
  }
}

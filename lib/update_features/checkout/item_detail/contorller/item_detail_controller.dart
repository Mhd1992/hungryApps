import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/base/base_controller.dart';
import '../../checkout_provider.dart';
import '../../model/order_item/item_detail_model.dart';

final itemDetailControllerProvider =
    StateNotifierProvider<ItemDetailController, AsyncValue<ItemDetailModel?>>(
      (ref) => ItemDetailController(ref),
    );

class ItemDetailController extends BaseController<ItemDetailModel> {
  Ref ref;

  ItemDetailController(this.ref);

  Future<void> getOrder(int id) async {
    final repo = ref.read(checkoutRepoProvider);
    loadOnce(() => repo.getOrder(id));
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/base/base_controller.dart';
import 'package:hungry/update_features/product_details/topping/data/topping_model.dart';
import 'package:hungry/update_features/product_details/topping/data/topping_provider.dart';

final toppingControllerProvider =
    StateNotifierProvider<ToppingController, AsyncValue<List<ToppingModel>?>>(
      (ref) => ToppingController(ref),
    );

class ToppingController extends BaseController<List<ToppingModel>> {
  Ref ref;

  ToppingController(this.ref);

  void loadToppings() async {
    final repo = ref.read(toppingRepoProvider);
    await loadOnce(() => repo.loadTopping());
  }

  /*
 //todo handle controller to return model instead of List<model>
 void getTopping (int toppingId) async{
    final repo = ref.read(toppingRepoProvider);
    await request(()=>repo.getTopping(toppingId));
}*/
}

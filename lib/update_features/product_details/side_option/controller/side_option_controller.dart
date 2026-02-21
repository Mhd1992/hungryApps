import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/base/base_controller.dart';
import 'package:hungry/update_features/product_details/side_option/data/side_option_model.dart';
import 'package:hungry/update_features/product_details/side_option/data/side_option_provider.dart';

final sideOptionControllerProvider =
    StateNotifierProvider<
      SideOptionController,
      AsyncValue<List<SideOptionModel>?>
    >((ref) => SideOptionController(ref));

class SideOptionController extends BaseController<List<SideOptionModel>> {
  Ref ref;

  SideOptionController(this.ref);

  void loadSideOption() async {
    final repo = ref.read(sideOptionRepoProvider);
    await loadOnce(() => repo.loadSideOption());
  }
}

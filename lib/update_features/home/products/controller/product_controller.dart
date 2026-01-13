import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/core/base/base_controller.dart';
import 'package:hungry/update_features/home/products/data/product_model.dart';
import 'package:hungry/update_features/home/products/data/product_provider.dart';

final productControllerProvider =
    StateNotifierProvider<ProductController, AsyncValue<List<ProductModel>?>>(
      (ref) => ProductController(ref),
    );

class ProductController extends BaseController<List<ProductModel>> {
  Ref ref;
  ProductController(this.ref);
  void loadAllProduct() async {
    final repo = ref.read(productRepoProvider);
    await loadOnce(() => repo.getAllProducts());
  }
}

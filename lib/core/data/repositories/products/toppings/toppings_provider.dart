import 'package:hungry/core/data/repositories/products/toppings/toppings_repo.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/core/data/base_controller.dart';

final toppingProvider = Provider<ToppingRepo>((ref) => ToppingRepo(ref));

final toppingControllerProvider =
    StateNotifierProvider<
      BaseController<List<ToppingModel>>,
      AsyncValue<List<ToppingModel>>
    >((ref) => BaseController<List<ToppingModel>>(ref.read(toppingProvider)));

import 'package:hungry/core/data/repositories/products/toppings/toppings_repo.dart';
import 'package:hungry/core/utils/exported_file.dart';

final toppingProvider = Provider<ToppingRepo>((ref) => ToppingRepo(ref));

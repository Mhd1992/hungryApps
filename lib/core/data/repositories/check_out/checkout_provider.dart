import 'package:hungry/core/data/base_controller.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'checkout_repo.dart';

final checkoutRepoProvider = Provider<CheckOutRepo>((ref) {
  return CheckOutRepo(ref);
});

// to handle UI state
final checkoutControllerProvider =
    StateNotifierProvider<BaseController<String>, AsyncValue<String>>(
      (ref) => BaseController<String>(ref.read(checkoutRepoProvider)),
    );

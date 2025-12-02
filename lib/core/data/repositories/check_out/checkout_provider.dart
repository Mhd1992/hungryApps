import '../../../utils/exported_file.dart';
import 'checkout_repo.dart';

final checkoutRepoProvider = Provider<CheckOutRepo>((ref) {
  return CheckOutRepo(ref);
});

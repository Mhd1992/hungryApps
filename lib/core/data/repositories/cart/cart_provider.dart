import 'package:hungry/core/utils/exported_file.dart';

import 'cart_repo_provider.dart';

final cartRepoProvider = Provider<CartRepoProvider>((ref) {
  return CartRepoProvider(ref);
});

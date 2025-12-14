import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_repo.dart';

final authProvider = Provider<AuthRepo>((ref) {
  return AuthRepo(ref);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/networks/dio_provider.dart';
import 'auth_api.dart';
import 'auth_repo.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.read(dioProvider);
  return AuthApi(dio);
});

final authRepoProvider = Provider<AuthRepo>((ref) {
  final api = ref.read(authApiProvider);
  return AuthRepo(api);
});

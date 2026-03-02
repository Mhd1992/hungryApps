import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/update_features/user/data/user_api.dart';
import 'package:hungry/update_features/user/data/user_repo.dart';

import '../../../core/networks/dio_provider.dart';

final userApiProvider = Provider<UserApi>((ref) {
  final dio = ref.read(dioProvider);
  return UserApi(dio);
});

final userRepoProvider = Provider<UserRepo>((ref) {
  final api = ref.read(userApiProvider);
  return UserRepo(api);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/utils/exported_file.dart' hide AuthRepo;

import '../../../../features/auth/data/models/user_model.dart';
import '../../base_controller.dart';
import 'auth_repo.dart';

final authProvider = Provider<AuthRepo>((ref) {
  return AuthRepo(ref);
});

final authControllerProvider =
    StateNotifierProvider<BaseController<UserModel>, AsyncValue<UserModel>>(
      (ref) => BaseController<UserModel>(ref.read(authProvider)),
    );

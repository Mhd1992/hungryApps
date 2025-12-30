import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/core/base/base_controller.dart';

import '../../../../update_features/user/data/user_model.dart';
import '../../../../update_features/user/data/user_provider.dart';

final userControllerProvider =
    StateNotifierProvider<UserController, AsyncValue<UserModel?>>(
      (ref) => UserController(ref),
    );

class UserController extends BaseController<UserModel?> {
  final Ref ref;

  UserController(this.ref);

  void getProfile() {
    final repo = ref.read(userRepoProvider);
    controlState(() => repo.getProfile());
  }

  void updateUserData(UserModel userModel) {
    final repo = ref.read(userRepoProvider);
    controlState(() => repo.updateUserData(userModel));
  }

  Future<void> logout() async {
    final repo = ref.read(userRepoProvider);
    await repo.logout();
    state = const AsyncValue.data(null);
  }
}

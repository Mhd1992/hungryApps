import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/base/base_controller.dart';
import 'package:hungry/features/auth/view/controller/user_ui_state.dart';

import '../../../../update_features/user/data/user_model.dart';
import '../../../../update_features/user/data/user_provider.dart';

final userControllerProvider =
    StateNotifierProvider<UserController, AsyncValue<UserModel?>>(
      (ref) => UserController(ref),
    );

class UserController extends BaseController<UserModel?> {
  final Ref ref;

  UserController(this.ref);

  void getProfile() async {
    final repo = ref.read(userRepoProvider);
    await loadOnce(() => repo.getProfile());
  }

  void updateUserData(UserModel userModel) async {
    final repo = ref.read(userRepoProvider);
    ref.read(userUiControllerProvider.notifier).isUpdate(true);

    final updatedUser = await repo.updateUserData(userModel);
    updateCache(updatedUser);
    ref.read(userUiControllerProvider.notifier).isUpdate(false);
  }

  Future<void> logout({VoidCallback? onSuccess}) async {
    final repo = ref.read(userRepoProvider);
    ref.read(userUiControllerProvider.notifier).isLogout(true);
    await repo.logout();
    state = const AsyncValue.data(null);

    ref.read(userUiControllerProvider.notifier).isLogout(true);
    if (onSuccess != null) onSuccess();

    clearCache();
  }
}

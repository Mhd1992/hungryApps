import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/base/base_controller.dart';
import 'package:hungry/features/auth/view/controller/user_ui_state.dart';
import 'package:hungry/update_features/user/data/user_provider.dart';

final userActionControllerProvider =
    StateNotifierProvider<UserActionController, AsyncValue<String?>>(
      (ref) => UserActionController(ref),
    );

class UserActionController extends BaseController<String?> {
  Ref ref;

  UserActionController(this.ref);

  Future<void> logOut({VoidCallback? onSuccess}) async {
    final repo = ref.read(userRepoProvider);
    ref.read(userUiControllerProvider.notifier).isLogout(true);
    await requestAction(
      () => repo.logout(),
      (response) => response.message ?? "Logout successfully",
    );
    if (onSuccess != null) onSuccess();
    state = const AsyncValue.data(null);

    ref.read(userUiControllerProvider.notifier).isLogout(true);
    clearCache();
  }
}

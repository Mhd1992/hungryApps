import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/update_features/auth/data/auth_model.dart';

import '../../../core/base/base_controller.dart';
import '../data/auth_provider.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<AuthModel?>>(
      (ref) => AuthController(ref),
    );

class AuthController extends BaseController<AuthModel?> {
  final Ref ref;

  AuthController(this.ref);

  void login(String email, String password, {VoidCallback? onSuccess}) async {
    final repo = ref.read(authRepoProvider);
    await request(() => repo.login(email, password));
    if (onSuccess != null) onSuccess();
  }

  void register(String name, String email, String password) async {
    final repo = ref.read(authRepoProvider);
    await request(() => repo.register(name, email, password));
  }
}

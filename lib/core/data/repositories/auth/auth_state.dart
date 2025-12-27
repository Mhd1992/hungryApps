import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/controller/repo_state_controller.dart';

import '../../../../features/auth/data/models/user_model.dart';
import 'auth_provider.dart';

final authState =
    StateNotifierProvider<
      RepoStateController<UserModel?>,
      AsyncValue<UserModel?>
    >((ref) {
      final repo = ref.watch(authProvider);
      return repo.controller;
    });

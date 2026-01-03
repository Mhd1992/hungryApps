import 'package:hungry/core/base/base_repo.dart';

import 'auth_api.dart';
import 'auth_model.dart';

class AuthRepo extends BaseRepo {
  final AuthApi api;

  AuthRepo(this.api);

  Future<AuthModel> login(String email, String password) {
    return runData(() => api.login({'email': email, 'password': password}));
  }

  Future<AuthModel> register(String name, String email, String password) {
    return runData(
      () => api.login({'name': name, 'email': email, 'password': password}),
    );
  }
}

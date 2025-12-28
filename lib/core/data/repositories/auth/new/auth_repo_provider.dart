import 'package:hungry/core/data/repositories/auth/auth_provider.dart';
import 'package:hungry/core/provider/repo_providers.dart';

final loginRepoProvider = RepoProvider.family.future(
  (ref, ({String email, String password}) arg) async => ref
      .read(authProvider)
      .apiService
      .login({"email": arg.email, "password": arg.password}),
);

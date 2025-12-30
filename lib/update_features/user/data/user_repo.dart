import 'package:hungry/core/base/base_repo.dart';
import 'package:hungry/update_features/user/data/user_api.dart';

import 'package:hungry/update_features/user/data/user_model.dart';

class UserRepo extends BaseRepo {
  final UserApi api;

  UserRepo(this.api);

  Future<UserModel> getProfile() async {
    return runData(() => api.getProfile());
  }

  Future<UserModel> updateUserData(UserModel updateRequest) async {
    final data = await updateRequest.toFormData();
    return runData(() => api.updateUserData(data));
  }

  Future<void> logout() async {
    return runAction(() => api.logout());
  }
}

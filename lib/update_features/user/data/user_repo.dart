import 'package:hungry/core/base/base_repo.dart';
import 'package:hungry/update_features/user/data/user_api.dart';

import 'package:hungry/update_features/user/data/user_model.dart';

class UserRepo extends BaseRepo<UserModel> {
  final UserApi api;

  UserRepo(this.api);

  Future<UserModel> getProfile() {
    return run(() => api.getProfile());
  }

  Future<UserModel> updateUserData(UserModel updateRequest) async {
    final data = await updateRequest.toFormData();
    return run(() => api.updateUserData(data));
  }
}

import 'package:hungry/core/base/base_repo.dart';
import 'package:hungry/update_features/user/data/user_api.dart';

import 'package:hungry/update_features/user/data/user_model.dart';

import '../../../core/networks/retrofit/model/base_response.dart';

class UserRepo extends BaseRepo {
  final UserApi api;

  UserRepo(this.api);

  Future<UserModel> getProfile() async {
    return loadData(() => api.getProfile());
  }

  Future<UserModel> updateUserData(UserModel updateRequest) async {
    final data = await updateRequest.toFormData();
    return loadData(() => api.updateUserData(data));
  }

  Future<BaseResponse<String?>> logout() async {
    return runAction(() => api.logout());
  }
}

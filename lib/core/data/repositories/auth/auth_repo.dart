import 'package:hungry/core/data/base_repo.dart';
import 'package:hungry/core/utils/exported_file.dart';

import 'auth_state.dart';

final _isGuest = StateProvider((ref) => false);
final updateProfile = StateProvider((ref) => false);

class AuthRepo extends BaseRepo<UserModel> {
  AuthRepo._internal(super.ref);

  factory AuthRepo(Ref ref) {
    return AuthRepo._internal(ref);
  }

  final ApiService _apiService = ApiService(DioClient().dio);
  UserModel? cachedUser;
  UserModel? user;

  Future<UserModel?> loginUser(
    Map<String, dynamic> param, {
    required WidgetRef ref,
  }) async {
    await handleRequestWithParam<BaseResponse<UserModel>, Map<String, dynamic>>(
      apiCall: _apiService.login,
      param: param,
      onSuccess: (success) {
        user = success.data;
        if (user?.token != null) {
          PrefHelper.saveToken(user!.token!);
        }
      },
    );
    return user;
  }

  Future<UserModel?> signUp(
    Map<String, dynamic> param, {
    required WidgetRef ref,
  }) async {
    await handleRequestWithParam<BaseResponse<UserModel>, Map<String, dynamic>>(
      apiCall: _apiService.register,
      param: param,
      onSuccess: (success) {
        user = success.data;
        if (user?.token != null) {
          PrefHelper.saveToken(user!.token!);
        }
      },
    );
    return user;
  }

  Future<UserModel?> updateProfileInfo({
    required UserModel? updateRequest,
    required WidgetRef ref,
  }) async {
    final updateData = await updateRequest!.toFormData();
    await handleRequestWithParam<BaseResponse<UserModel>, FormData>(
      apiCall: _apiService.updateUserData,
      param: updateData,
      onSuccess: (success) {
        user = success.data;
        if (user?.token != null) {
          PrefHelper.saveToken(user!.token!);
        }
        ref.read(updateProfile.notifier).state = true;
      },
    );
    return user;
  }

  Future<UserModel?> profile({
    required WidgetRef ref,
    updateData = false,
  }) async {
    final token = await PrefHelper.getToken();
    if (token == 'guest') {
      return null;
    }
    if (cachedUser != null && !updateData) {
      ref.read(authState.notifier).setData(cachedUser!);
      return cachedUser;
    }
    await handleRequest<UserModel>(
      apiCall: _apiService.getProfile,
      onSuccess: (success) {
        cachedUser = success;
      },
    );
    return cachedUser;
  }

  Future<UserModel?> autoLogin({required WidgetRef ref}) async {
    final token = await PrefHelper.getToken();
    if (token == 'guest') return null;
    cachedUser = await profile(ref: ref);
    ref.read(authState.notifier).setData(cachedUser!);
    return cachedUser;
  }

  Future<void> continueAsGuest({required WidgetRef ref}) async {
    ref.read(_isGuest.notifier).state = true;
    await PrefHelper.saveToken('guest');
  }

  Future<void> logout({required WidgetRef ref}) async {
    handleRequest(
      apiCall: _apiService.logout,
      onSuccess: (success) async {
        await PrefHelper.clearToken();
        ref.read(_isGuest.notifier).state = false;
        cachedUser = null;
        if (ref.context.mounted) {
          Navigator.of(ref.context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginView()),
          );
        }
      },
    );
  }

  bool isGuest(WidgetRef ref) => ref.read(_isGuest);
  //bool updatedProfile(WidgetRef ref) => ref.read(_updateProfile);
  bool isLoggedIn(WidgetRef ref) => !ref.watch(_isGuest) && cachedUser != null;
  UserModel? get cachedData => cachedUser;
}

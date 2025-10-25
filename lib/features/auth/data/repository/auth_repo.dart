import 'package:hungry/core/utils/exported_file.dart';

class AuthRepo {
  AuthRepo._internal();

  static final AuthRepo _instance = AuthRepo._internal();

  factory AuthRepo() => _instance;

  ApiServices apiServices = ApiServices();
  UserModel? _cachedUser;
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiServices.postData('/login', {
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }

      final apiResponse = ApiResponse<UserModel>.fromJson(
        response.data,
        (data) => UserModel.fromJson(data),
      );

      if (apiResponse.code == 200) {
        final user = apiResponse.data!;
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      }
    } on DioException catch (error) {
      throw ApiException.handleError(error);
    } catch (error) {
      throw ApiError(message: error.toString());
    }
    throw ApiError(message: 'Unknown error occurred login failed.');
  }

  Future<UserModel?> signUp(String name, String email, String password) async {
    try {
      final response = await apiServices.postData('/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }

      final apiResponse = ApiResponse<UserModel>.fromJson(
        response.data,
        (data) => UserModel.fromJson(data),
      );

      if (apiResponse.code == 200 || apiResponse.code == 201) {
        final user = apiResponse.data!;
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      }
    } on DioException catch (error) {
      throw ApiException.handleError(error);
    } catch (error) {
      throw ApiError(message: error.toString());
    }
    throw ApiError(message: 'Unknown error occurred signup failed.');
  }

  Future<UserModel?> getProfile() async {
    try {
      if (_cachedUser != null) {
        return _cachedUser;
      }
      final response = await apiServices.getData('/profile');

      if (response is ApiError) {
        throw response;
      }

      final apiResponse = ApiResponse<UserModel>.fromJson(
        response.data,
        (data) => UserModel.fromJson(data),
      );

      if (apiResponse.code == 200) {
        final user = apiResponse.data!;
        _cachedUser = user;
        return user;
      }
    } on DioException catch (error) {
      throw ApiException.handleError(error);
    } catch (error) {
      throw ApiError(message: error.toString());
    }
    throw ApiError(message: 'Unknown error occurred getProfile data failed.');
  }

  void clearCache() {
    _cachedUser = null;
  }
}

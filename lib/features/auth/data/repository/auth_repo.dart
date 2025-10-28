import 'package:hungry/core/utils/exported_file.dart';

class AuthRepo {
  AuthRepo._internal();

  static final AuthRepo _instance = AuthRepo._internal();

  factory AuthRepo() => _instance;

  ApiServices apiServices = ApiServices();
  UserModel? _cachedUser;
  bool _isGuest = false;

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiServices.postData(
        '/login',
        body: {'email': email, 'password': password},
      );

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
      final response = await apiServices.postData(
        '/register',
        body: {'name': name, 'email': email, 'password': password},
      );

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

  Future<UserModel?> getProfile({bool updatedData = false}) async {
    final token = await PrefHelper.getToken();
    if (token == 'guest') {
      print('AM GUEST');
      return null;
    }
    try {
      if (_cachedUser != null && !updatedData) {
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

  Future<UserModel?> updateUserData({
    required String name,
    required String email,
    required String address,
    String? image,
    String? visa,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'email': email,
      'address': address,
      if (image != null && image.isNotEmpty)
        'image': await MultipartFile.fromFile(image, filename: 'upload.jpg'),
      if (visa != null && visa.isNotEmpty) 'Visa': visa,
    });

    try {
      final response = await apiServices.postData(
        '/update-profile',
        formData: formData,
      );

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
    throw ApiError(message: 'Unknown error occurred update profile failed.');
  }

  Future<void> logout() async {
    final response = await apiServices.postData('/logout', body: {});

    final apiResponse = ApiResponse<void>.fromJson(response.data, (data) {});
    if (apiResponse.code == 200) {
      await PrefHelper.clearToken();
      _cachedUser = null;
      _isGuest = false;
    }
  }

  Future<UserModel?> autoLogin() async {
    final token = await PrefHelper.getToken();
    if (token == 'guest') return null;
    _isGuest = false;
    try {
      _cachedUser = await getProfile();
      return _cachedUser;
    } catch (_) {
      await PrefHelper.clearToken();
      _cachedUser = null;
      _isGuest = true;
      return null;
    }
  }

  Future<void> continueAsGuest() async {
    _isGuest = true;
    await PrefHelper.saveToken('guest');
  }

  UserModel? get cachedUser => _cachedUser;
  bool get isLoggedIn => !_isGuest && _cachedUser != null;
}

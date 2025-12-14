import 'package:hungry/core/utils/exported_file.dart';

class AuthRepoV1 {
  AuthRepoV1._internal();

  static final AuthRepoV1 _instance = AuthRepoV1._internal();

  factory AuthRepoV1() => _instance;

  final ApiService _apiService = ApiService(DioClient().dio);

  ApiServices apiServices = ApiServices();
  UserModel? _cachedUser;
  bool _isGuest = false;

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await _apiService.login({
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }
      if (response.code == 200) {
        final user = response.data;
        if (user?.token != null) {
          await PrefHelper.saveToken(user!.token!);
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

  Future<UserModel?> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _apiService.register({
        'name': name,
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }

      final apiResponse = response;

      if (apiResponse.code == '200' || apiResponse.code == '201') {
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
    throw ApiError(message: 'Unknown error occurred register failed.');
  }

  Future<UserModel?> profile({bool updatedData = false}) async {
    final token = await PrefHelper.getToken();
    if (token == 'guest') {
      return null;
    }
    try {
      if (_cachedUser != null && !updatedData) {
        return _cachedUser;
      }
      final response = await _apiService.profile('profile');

      if (response is ApiError) {
        throw response;
      }

      final apiResponse = response;

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

  Future<UserModel?> editProfile({
    required String name,
    required String email,
    required String address,
    String? imagePath,
    String? visa,
  }) async {
    MultipartFile? imageFile;
    if (imagePath != null && imagePath.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        imagePath,
        filename: 'upload.jpg',
      );
    }

    final formData = FormData.fromMap({
      'name': name,
      'email': email,
      'address': address,
      if (visa != null && visa.isNotEmpty) 'Visa': visa,
      if (imageFile != null) 'image': imageFile,
    });

    final response = await _apiService.updateUserData(formData);

    if (response.code == 200 && response.data != null) {
      final user = response.data!;
      if (user.token != null) await PrefHelper.saveToken(user.token!);
      return user;
    } else {
      throw Exception(response.message);
    }
  }

  Future<void> logout() async {
    print('AM using retorfit');

    final response = await _apiService.logout();

    final apiResponse = response;
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
      _cachedUser = await profile();
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
  bool get isGuest => _isGuest;
  bool get isLoggedIn => !_isGuest && _cachedUser != null;
}

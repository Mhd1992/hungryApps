import 'package:dio/dio.dart';
import 'package:hungry/core/networks/api_error.dart';
import 'package:hungry/core/networks/api_exceptions.dart';
import 'package:hungry/core/networks/api_sevices.dart';
import 'package:hungry/core/utils/pref_helpers.dart';
import 'package:hungry/features/auth/data/user_model.dart';

class AuthRepo {
  ApiServices apiServices = ApiServices();

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiServices.postData('/login', {
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }
      if (response.data['code'] == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        final user = UserModel.fromJson(data);
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
  }
}

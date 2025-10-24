import 'package:dio/dio.dart';
import 'package:hungry/core/networks/api_error.dart';
import 'package:hungry/core/networks/api_exceptions.dart';
import 'package:hungry/core/networks/api_sevices.dart';
import 'package:hungry/core/utils/pref_helpers.dart';
import 'package:hungry/features/auth/data/api_response_model.dart';
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

      final apiResponse = ApiResponse<UserModel>.fromJson(
        response.data,
        (data) => UserModel.fromJson(data),
      );

      if (apiResponse.code == 200 && apiResponse.data != null) {
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
  }
}

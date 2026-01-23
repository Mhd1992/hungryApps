import 'package:hungry/core/networks/api_exceptions.dart';

import '../networks/retrofit/model/base_response.dart';

abstract class BaseRepo {
  Future<T> runData<T>(Future<BaseResponse<T>> Function() request) async {
    final response = await request();

    if (response.data == null) {
      throw Exception("No Data Returned !!! ");
    }
    return response.data!;
  }

  Future<T?> runOptional<T>(Future<BaseResponse<T?>> Function() request) async {
    final response = await request();
    return response.data;
  }

  Future<BaseResponse<String?>> runAction(
    Future<BaseResponse<dynamic>> Function() request,
  ) async {
    final message = await request();
    return BaseResponse(code: 200, message: message.message);
  }
}

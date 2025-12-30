import '../networks/base_response.dart';

abstract class BaseRepo {
  Future<T> runData<T>(Future<BaseResponse<T>> Function() request) async {
    final response = await request();
    if (response.data == null) {
      throw Exception('API returned null data');
    }
    return response.data!;
  }

  Future<T?> runOptional<T>(Future<BaseResponse<T>> Function() request) async {
    final response = await request();
    return response.data!;
  }

  Future<void> runAction(
    Future<BaseResponse<dynamic>> Function() request,
  ) async {
    await request();
  }
}

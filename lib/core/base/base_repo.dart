import '../networks/base_response.dart';

abstract class BaseRepo<T> {
  Future<T> run(Future<BaseResponse<T>> Function() request) async {
    try {
      final response = await request();
      return response.data as T;
    } catch (e) {
      rethrow;
    }
  }
}

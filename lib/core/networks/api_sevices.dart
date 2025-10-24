import 'package:hungry/core/utils/exported_file.dart';

class ApiServices {
  DioClient dioClient = DioClient();

  ///get
  Future<dynamic> getData(String endPoint) async {
    try {
      final response = await dioClient.dio.get(endPoint);
      return response;
    } on DioException catch (e) {
      return ApiException.handleError(e);
    }
  }

  /// post
  Future<dynamic> postData(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await dioClient.dio.post(endPoint, data: body);
      return response;
    } on DioException catch (e) {
      return ApiException.handleError(e);
    }
  }

  /// post
  Future<dynamic> putData(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await dioClient.dio.put(endPoint, data: body);
      return response;
    } on DioException catch (e) {
      return ApiException.handleError(e);
    }
  }

  /// post
  Future<dynamic> deleteData(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await dioClient.dio.delete(endPoint, data: body);
      return response;
    } on DioException catch (e) {
      return ApiException.handleError(e);
    }
  }
}

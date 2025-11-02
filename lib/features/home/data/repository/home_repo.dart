import 'package:hungry/core/networks/dio_client.dart';
import 'package:hungry/core/networks/retrofit/api_service.dart';
import 'package:hungry/core/networks/retrofit/model/category/category_model.dart';

import '../../../../core/utils/exported_file.dart';

class HomeRepo {
  HomeRepo._internal();

  static final HomeRepo _instance = HomeRepo._internal();

  factory HomeRepo() => _instance;

  final ApiService _apiService = ApiService(DioClient().dio);
  List<CategoryModel>? _cachedCategories;
  Future<List<CategoryModel>> loadCategories() async {
    try {
      if (_cachedCategories != null && _cachedCategories!.isNotEmpty) {
        return _cachedCategories!;
      }
      final response = await _apiService.getCategories();
      if (response is ApiError) {
        throw response;
      }
      if (response.code == 200) {
        _cachedCategories = response.data ?? [];
        return response.data ?? [];
        // return categories!;
      }
    } catch (error) {
      throw ApiError(message: error.toString());
    }
    throw ApiError(message: 'Unknown error occurred loadCategory failed.');
  }
}

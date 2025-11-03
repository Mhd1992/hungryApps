import 'package:hungry/core/networks/api_error.dart';
import 'package:hungry/core/networks/dio_client.dart';
import 'package:hungry/core/networks/retrofit/api_service.dart';
import 'package:hungry/core/networks/retrofit/model/side_option/side_option_model.dart';
import 'package:hungry/core/networks/retrofit/model/topping/topping_model.dart';

class ProductOptionRepo {
  ProductOptionRepo._internal();
  static final ProductOptionRepo _instance = ProductOptionRepo._internal();

  factory ProductOptionRepo() => _instance;

  final ApiService _apiService = ApiService(DioClient().dio);
  List<ToppingModel>? _cachedToppings;
  List<SideOptionModel>? _cachedSideOptions;
  Future<List<ToppingModel>> loadToppings() async {
    try {
      if (_cachedToppings != null && _cachedToppings!.isNotEmpty) {
        return _cachedToppings!;
      }
      final response = await _apiService.getToppings();
      if (response is ApiError) {
        throw response;
      }
      if (response.code == 200) {
        _cachedToppings = response.data ?? [];
        return response.data ?? [];
      }
    } catch (error) {
      throw ApiError(message: error.toString());
    }
    throw ApiError(message: 'Unknown error occurred loadCategory failed.');
  }

  Future<List<SideOptionModel>> loadSideOptions() async {
    try {
      if (_cachedSideOptions != null && _cachedSideOptions!.isNotEmpty) {
        return _cachedSideOptions!;
      }
      final response = await _apiService.getSideOptions();
      if (response is ApiError) {
        throw response;
      }
      if (response.code == 200) {
        _cachedSideOptions = response.data ?? [];
        return response.data ?? [];
      }
    } catch (error) {
      throw ApiError(message: error.toString());
    }
    throw ApiError(message: 'Unknown error occurred loadCategory failed.');
  }
}

import 'package:dio/dio.dart';
import '../../../../core/networks/retrofit/model/base_response.dart';
import 'package:retrofit/retrofit.dart';
import 'category_model.dart';

part 'category_api.g.dart';

@RestApi(baseUrl: "https://sonic-zdi0.onrender.com/api")
abstract class CategoryApi {
  factory CategoryApi(Dio dio, {String baseUrl}) = _CategoryApi;

  @GET("/categories")
  Future<BaseResponse<List<CategoryModel>>> getCategories();
}

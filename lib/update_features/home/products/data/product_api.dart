import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/networks/retrofit/model/base_response.dart';
import 'product_model.dart';

part 'product_api.g.dart';

@RestApi(baseUrl: "https://sonic-zdi0.onrender.com/api")
abstract class ProductApi {
  factory ProductApi(Dio dio, {String baseUrl}) = _ProductApi;

  @GET("/products")
  Future<BaseResponse<List<ProductModel>>> getProducts();
}

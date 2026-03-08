import 'package:dio/dio.dart';
import 'package:hungry/core/constants/app_strings.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/networks/retrofit/model/base_response.dart';
import 'topping_model.dart';

part 'topping_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ToppingApi {
  factory ToppingApi(Dio dio, {String baseUrl}) = _ToppingApi;
  @GET("/toppings")
  Future<BaseResponse<List<ToppingModel>>> loadToppings();

  @GET("/toppings/{id}")
  Future<BaseResponse<ToppingModel>> getTopping(@Path("id") int id);
}

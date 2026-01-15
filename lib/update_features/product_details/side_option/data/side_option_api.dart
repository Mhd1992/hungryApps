import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/networks/retrofit/model/base_response.dart';
import 'side_option_model.dart';

part 'side_option_api.g.dart';

@RestApi(baseUrl: "https://sonic-zdi0.onrender.com/api")
abstract class SideOptionApi {
  factory SideOptionApi(Dio dio, {String baseUrl}) = _SideOptionApi;

  @GET("/side-options")
  Future<BaseResponse<List<SideOptionModel>>> loadSideOptions();
}

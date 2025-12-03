import 'package:hungry/core/data/base_repo.dart';
import 'package:hungry/core/networks/retrofit/model/cart/items/item_model.dart';
import 'package:hungry/core/networks/retrofit/model/orders/order_model.dart';

import '../../../utils/exported_file.dart';

class CheckOutRepo extends BaseRepo<String> {
  CheckOutRepo._internal(super.ref);

  factory CheckOutRepo(Ref ref) {
    return CheckOutRepo._internal(ref);
  }

  final ApiService _apiService = ApiService(DioClient().dio);

  Future<void> checkout(CartRequest cartModel, {required WidgetRef ref}) async {
    await handleRequestWithParam<BaseResponse<OrderModel>, CartRequest>(
      apiCall: _apiService.checkOut,
      param: cartModel,
      onSuccess: (data) async {
        data.data!.id;
      },
    );
  }

  // Add your methods and properties here
}

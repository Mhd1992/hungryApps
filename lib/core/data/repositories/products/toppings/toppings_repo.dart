import 'package:hungry/core/data/base_repo.dart';
import 'package:hungry/core/utils/exported_file.dart';

final _toppingProvider = StateProvider<AsyncValue<List<ToppingModel>>>(
  (ref) => const AsyncValue.loading(),
);

class ToppingRepo extends BaseRepo<List<ToppingModel>> {
  ToppingRepo._internal(super.ref);

  factory ToppingRepo(Ref ref) {
    return ToppingRepo._internal(ref);
  }

  final ApiService _apiService = ApiService(DioClient().dio);

  Future<List<ToppingModel>?> fetchTopping({required WidgetRef ref}) async {
    List<ToppingModel>? toppings;
    await handleRequest(
      apiCall: _apiService.getToppings,
      onSuccess: (data) {
        toppings = data;
      },
    );
    return toppings;
  }
}

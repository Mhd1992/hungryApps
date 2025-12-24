import 'package:hungry/core/data/base_repo.dart';
import 'package:hungry/core/utils/exported_file.dart';

class SideOptionRepo extends BaseRepo<List<SideOptionModel>> {
  SideOptionRepo._internal(super.ref);

  factory SideOptionRepo(Ref ref) {
    return SideOptionRepo._internal(ref);
  }

  final ApiService _apiService = ApiService(DioClient().dio);

  Future<List<SideOptionModel>?> fetchSideOption({
    required WidgetRef ref,
  }) async {
    List<SideOptionModel>? sideOptions;
    await handleRequest(
      apiCall: _apiService.getSideOptions,
      onSuccess: (data) {
        sideOptions = data;
      },
    );
    return sideOptions;
  }
}

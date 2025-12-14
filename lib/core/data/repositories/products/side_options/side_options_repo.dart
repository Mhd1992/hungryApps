import 'package:hungry/core/data/base_repo.dart';
import 'package:hungry/core/utils/exported_file.dart';

class SideOptionRepo extends BaseRepo<List<SideOptionModel>> {
  SideOptionRepo._internal(super.ref);

  factory SideOptionRepo(Ref ref) {
    return SideOptionRepo._internal(ref);
  }

  final ApiService _apiService = ApiService(DioClient().dio);

  Future<void> fetchSideOption({required WidgetRef ref}) async {
    await handleRequest(
      apiCall: _apiService.getSideOptions,
      onSuccess: (data) {},
    );
  }
}

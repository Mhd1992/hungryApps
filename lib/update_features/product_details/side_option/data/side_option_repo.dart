import 'package:hungry/core/base/base_repo.dart';
import 'package:hungry/update_features/product_details/side_option/data/side_option_api.dart';
import 'side_option_model.dart';

class SideOptionRepo extends BaseRepo {
  final SideOptionApi _api;

  SideOptionRepo(this._api);

  Future<List<SideOptionModel>> loadSideOption() async {
    return loadData(() => _api.loadSideOptions());
  }
}

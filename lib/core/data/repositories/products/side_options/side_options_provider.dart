import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/data/base_controller.dart';
import 'package:hungry/core/data/repositories/products/side_options/side_options_repo.dart';
import 'package:hungry/core/utils/exported_file.dart';

final sideOptionProvider = Provider<SideOptionRepo>(
  (ref) => SideOptionRepo(ref),
);

final sideOptionControllerProvider =
    StateNotifierProvider<
      BaseController<List<SideOptionModel>>,
      AsyncValue<List<SideOptionModel>>
    >(
      (ref) =>
          BaseController<List<SideOptionModel>>(ref.read(sideOptionProvider)),
    );

import 'package:hungry/core/controller/repo_state_controller.dart';
import 'package:hungry/core/utils/exported_file.dart';

import 'categories_provider.dart';

final categoriesStateProvider =
    StateNotifierProvider<
      RepoStateController<List<CategoryModel>>,
      AsyncValue<List<CategoryModel>>
    >((ref) {
      final repo = ref.watch(categoriesProvider);
      return repo.controller;
    });

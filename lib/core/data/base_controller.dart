import 'package:hungry/core/utils/exported_file.dart';

import 'base_repo.dart';

class BaseController<T> extends StateNotifier<AsyncValue<T>> {
  final BaseRepo<T> repo;

  BaseController(this.repo) : super(const AsyncLoading()) {
    // Listen to repo changes
    repo.controller.addListener((repoState) {
      repoState.when(
        data: (data) => state = AsyncData(data),
        loading: () => state = const AsyncLoading(),
        error: (e, st) => state = AsyncError(e, st),
      );
    });
  }

  Future<void> updateData(Future<T?> Function() action) async {
    try {
      state = const AsyncLoading();
      final result = await action();
      if (result != null) state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> profile(Future<T?> Function() action) async {
    try {
      state = const AsyncLoading();
      final result = await action();
      if (result != null) state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

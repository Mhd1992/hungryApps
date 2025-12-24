import 'package:hungry/core/utils/exported_file.dart';

import 'base_repo.dart';

class BaseController<T> extends StateNotifier<AsyncValue<T>> {
  final BaseRepo<T> repo;

  BaseController(this.repo) : super(const AsyncLoading()) {
    repo.controller.addListener((repoState) {
      repoState.when(
        data: (data) => state = AsyncData(data),
        loading: () => state = const AsyncLoading(),
        error: (e, st) => state = AsyncError(e, st),
      );
    });
  }

  Future<void> handleData(Future<T?> Function() action) async {
    final cached = repo.cachedData;
    if (cached != null) {
      state = AsyncData(cached);
      return;
    }
    try {
      state = const AsyncLoading();
      final result = await action();
      if (result != null) state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(ApiException.handleError(e as DioException), st);
    }
  }

  Future<void> handleAction(Future<void> Function() action) async {
    try {
      state = const AsyncLoading();
      await action();
    } catch (e, st) {
      state = AsyncError(ApiException.handleError(e as DioException), st);
    }
  }
}

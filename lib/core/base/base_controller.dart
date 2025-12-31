import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class BaseController<T> extends StateNotifier<AsyncValue<T?>> {
  BaseController() : super(const AsyncLoading());

  T? _cachedData;

  bool get hasCache => _cachedData != null;

  Future<void> loadOnce(Future<T> Function() action) async {
    if (_cachedData != null) {
      state = AsyncData(_cachedData);
      return;
    }
    state = const AsyncLoading();
    try {
      final result = await action();
      _cachedData = result;
      state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void updateCache(T data) {
    _cachedData = data;
    state = AsyncData(data);
  }

  void clearCache() {
    _cachedData = null;
    state = const AsyncLoading();
  }
}

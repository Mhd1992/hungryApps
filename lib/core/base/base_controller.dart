import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/utils/exported_file.dart';

class BaseController<T> extends StateNotifier<AsyncValue<T?>> {
  BaseController() : super(const AsyncData(null));

  T? _cachedData;

  bool get hasCache => _cachedData != null;

  Future<void> request(Future<T> Function() action) async {
    state = const AsyncLoading();
    try {
      final result = await action();
      state = AsyncData(result);
    } on DioException catch (e, st) {
      state = AsyncError(ApiException.handleError(e), st);
    } catch (e, st) {
      state = AsyncError(ApiException(), st);
    }
  }

  Future<void> requestAction(
    Future<BaseResponse<String?>> Function()
    action, // action()   // does the API call
    T Function(BaseResponse<dynamic> response)
    mapper, // mapper()   // converts the response to T
  ) async {
    state = const AsyncLoading();
    try {
      final result = await action();
      state = AsyncData(mapper(result));
    } on DioException catch (e, st) {
      state = AsyncError(ApiException.handleError(e), st);
    } catch (e, st) {
      state = AsyncError(ApiException(), st);
    }
  }

  Future<void> loadOnce(
    Future<T> Function() action, {
    bool useCache = true,
  }) async {
    if (_cachedData != null && useCache) {
      print(
        'the type of cachedData is --------- \n${_cachedData.runtimeType}\n--------------',
      );
      state = AsyncData(_cachedData);
      return;
    }
    state = const AsyncLoading();
    try {
      final result = await action();
      _cachedData = result;
      state = AsyncData(result);
    } on DioException catch (e, st) {
      state = AsyncError(ApiException.handleError(e), st);
    } catch (e, st) {
      // state = AsyncError(ApiError(message: e.toString()), st);
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
    PrefHelper.clearToken();
  }
}

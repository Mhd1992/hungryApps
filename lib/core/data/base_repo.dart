import 'package:hungry/core/controller/repo_state_controller.dart';

import '../utils/exported_file.dart';

abstract class BaseRepo<T> {
  late RepoStateController<T> controller;
  T? cachedData;
  BaseRepo(Ref ref) {
    controller = RepoStateController<T>();
  }

  Future<void> handleRequestWithParam<R, P>({
    required Future<R> Function(P param) apiCall,
    required P param,
    required void Function(R result) onSuccess,
  }) async {
    try {
      controller.setLoading();
      final result = await apiCall(param);
      if (result != null) {
        final data = result as R;

        // Call onSuccess to cache or process
        onSuccess(data);

        // If R wraps the actual T, extract it
        T? valueToSet;
        if (data is BaseResponse<T>) {
          valueToSet = data.data;
        } else if (data is T) {
          valueToSet = data;
        }

        if (valueToSet != null) {
          controller.setData(valueToSet); // now listener will fire
        }
      }
    } catch (e, st) {
      controller.setError(e, st);
    }
  }

  /*
reviewed version without data extraction

Future<void> handleRequestWithParam<R, P>({
    required Future<R> Function(P param) apiCall,
    required P param,
    required void Function(R result) onSuccess,
  }) async {
    try {
      controller.setLoading();
      final result = await apiCall(param);
      if (result != null) {
        final data = result as R;
        onSuccess(data);

        if (data is T) {
          controller.setData(data as T);
        }
      }
    } catch (e, st) {
      //  controller.setError(e, st);
    }
  }*/

  Future<void> handleRequest<R>({
    required Future<BaseResponse<R>> Function() apiCall,
    required void Function(R result) onSuccess,
  }) async {
    final result = await apiCall();
    final data = result.data as R;

    onSuccess(data);
  }
}

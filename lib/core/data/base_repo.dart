import 'package:hungry/core/controller/repo_state_controller.dart';

import '../utils/exported_file.dart';

Provider<BaseRepo<T>> createRepoProvider<T>(BaseRepo<T> Function(Ref) create) {
  return Provider<BaseRepo<T>>((ref) => create(ref));
}

abstract class BaseRepo<T> {
  late RepoStateController<T> controller;

  BaseRepo(Ref ref) {
    controller = RepoStateController<T>();
  }

  void setLoadingState(bool value) {
    if (value) {
      controller.setLoading();
    }
  }

  Future<void> handleRequestWithParam<R, P>({
    required Future<BaseResponse<R>> Function(P param) apiCall,
    required P param,
    required void Function(R result) onSuccess,
  }) async {
    try {
      controller.setLoading();
      final result = await apiCall(param);
      if (result != null) {
        final data = result as R;

        onSuccess(data);
      } else {
        if (result.message != null && result.message!.isNotEmpty) {
          onSuccess(result.message as R);
        } else {
          onSuccess(null as R);
        }
      }
    } catch (e, st) {
      controller.setError(e, st);
    }
  }

  Future<void> handleRequest<R>({
    required Future<BaseResponse<R>> Function() apiCall,
    required void Function(R result) onSuccess,
  }) async {
    try {
      controller.setLoading();
      final result = await apiCall();
      final data = result.data as R;
      onSuccess(data);
      controller.setData(data as T);
    } catch (e, st) {
      controller.setError(e, st);
    }
  }
}

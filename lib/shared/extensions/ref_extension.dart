import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:hungry/core/networks/retrofit/model/base_response.dart';

extension BaseResponseAdapter<T> on ProviderListenable<AsyncValue<T>> {
  ProviderListenable<AsyncValue<BaseResponse<T>>> asBaseResponse({
    required String successMessage,
  }) {
    return Provider<AsyncValue<BaseResponse<T>>>((ref) {
      final state = ref.watch(this);

      return state.when(
        loading: () => const AsyncLoading(),
        data: (data) => AsyncData(
          BaseResponse<T>(code: 200, message: successMessage, data: data),
        ),
        error: (error, stack) => AsyncError(error, stack),
      );
    });
  }
}

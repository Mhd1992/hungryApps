import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class BaseController<T> extends StateNotifier<AsyncValue<T>> {
  BaseController() : super(const AsyncLoading());

  Future<void> controlState(Future<T> Function() action) async {
    state = const AsyncLoading();
    try {
      final result = await action();
      state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

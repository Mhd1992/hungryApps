import 'dart:async';

import 'package:dartz/dartz.dart' show Either;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/models/async_state.dart';
import 'package:hungry/core/models/response_failure.dart';

class StreamDataController<DataT> extends StateNotifier<AsyncState<DataT>> {
  StreamDataController(this._repo) : super(Init<DataT>()) {
    _listen();
  }

  final Stream<Either<ResponseFailure, DataT>> Function() _repo;
  StreamSubscription<Either<ResponseFailure, DataT>>? _subscription;

  void _listen() async {
    try {
      await _subscription?.cancel();

      state = Loading<DataT>();

      _subscription = _repo().listen(
        (result) {
          state = result.fold(
            (failure) => Failure<DataT>(failure),
            (data) => Loaded<DataT>(data),
          );
        },
        onError: (error) {
          state = Failure<DataT>(const ResponseFailure.unknown('error'));
        },
      );
    } catch (_) {}
  }

  @override
  void dispose() async {
    await _subscription?.cancel();
    super.dispose();
  }

  void update(DataT data) {
    if (!state.isLoaded) return;
    state = Loaded(data);
  }

  Future<void> reset() async {
    await _subscription?.cancel();
    state = const Init();
  }
}

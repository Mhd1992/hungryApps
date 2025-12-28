import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/form/app_form.dart';
import 'package:hungry/core/models/async_state.dart';
import 'package:hungry/core/models/response_failure.dart';

class FutureDataController<DataT> extends StateNotifier<AsyncState<DataT>>
    implements TryAgain {
  FutureDataController(this._repo) : super(Init<DataT>()) {
    _getData();
  }

  final Future<Either<ResponseFailure, DataT>> Function() _repo;

  Future<void> _getData() async {
    state = Loading<DataT>();
    await _getAsyncData();
  }

  Future<void> _getAsyncData({bool silent = false}) async {
    final result = await _repo();
    state = result.fold(
      (l) => silent ? state : Failure<DataT>(l),
      (r) => Loaded<DataT>(r),
    );
  }

  @Deprecated("This Bad for encasulation API.")
  void update(DataT data) {
    if (!state.isLoaded) return;
    state = Loaded(data);
  }

  Future<void> retry() => _getData();

  Future<void> refresh() => _getAsyncData(silent: true);

  @override
  void tryAgain() {
    _getData();
  }
}

abstract class DataController<DataT>
    extends AutoDisposeNotifier<AsyncState<DataT>> {}

class FutureDataControllerV2<DataT> extends DataController<DataT> {
  FutureDataControllerV2(this._repo);

  final Future<Either<ResponseFailure, DataT>> Function() Function(Ref ref)
  _repo;

  @override
  AsyncState<DataT> build() {
    _getData();
    return Loading<DataT>();
  }

  void _getData() async {
    final result = await _repo(ref)();
    state = result.fold((failure) => Failure(failure), (data) => Loaded(data));
  }
}

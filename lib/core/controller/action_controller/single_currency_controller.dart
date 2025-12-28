import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hungry/core/models/async_state.dart';
import 'package:hungry/core/provider/repo_providers.dart';

import 'action_controllers.dart';

class _Fire<Arg> extends Equatable {
  const _Fire(this.arg);
  final Arg? arg;

  @override
  List<Object?> get props => [arg];
}

class ConcurrentController<DataT, Arg extends Record?>
    extends Bloc<_Fire<Arg>, ({Arg? arg, AsyncState<DataT> data})> {
  ConcurrentController({
    required Future<EitherResponse<DataT>?> Function(Arg? arg) repo,
    required ActionStrategy strategy,
    @Deprecated('Do not use this.') Duration? debounceBeforeRequrest,
  }) : _repo = repo,
       _debounceBeforeRequrest = debounceBeforeRequrest,
       super((arg: null, data: Init<DataT>())) {
    _setupEventHandler(strategy);
  }

  final Future<EitherResponse<DataT>?> Function(Arg? arg) _repo;

  final Duration? _debounceBeforeRequrest;

  void fire(Arg? arg) => add(_Fire(arg));

  void _setupEventHandler(ActionStrategy strategy) {
    on<_Fire<Arg>>((event, emit) async {
      emit((arg: event.arg, data: Loading<DataT>()));
      if (_debounceBeforeRequrest != null) {
        await Future.delayed(_debounceBeforeRequrest!);
      }

      final result = await _repo(event.arg);

      if (result != null) {
        emit(
          result.fold(
            (l) => (arg: event.arg, data: Failure<DataT>(l)),
            (r) => (arg: event.arg, data: Loaded<DataT>(r)),
          ),
        );
      }

      // TODO: i am not sure about always reset state to init.
      emit((arg: event.arg, data: Init<DataT>()));
    }, transformer: _getTransformer<_Fire<Arg>>(strategy));
  }

  Stream<E> Function(Stream<E>, Stream<E> Function(E))?
  _getTransformer<E extends _Fire<Arg>>(ActionStrategy strategy) {
    switch (strategy) {
      case ActionStrategy.droppable:
        return droppable();
      case ActionStrategy.restartable:
        return restartable();
      case ActionStrategy.sequential:
        return sequential();
      case ActionStrategy.concurrent:
        return concurrent();
    }
  }
}

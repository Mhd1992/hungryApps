import 'dart:async';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hungry/core/models/async_state.dart';
import 'package:hungry/core/provider/data_controllers_provider.dart';
import 'package:hungry/core/provider/repo_providers.dart';
import 'package:riverpod/riverpod.dart';

import 'single_currency_controller.dart';

export 'extensions.dart';

part 'action_strategy.dart';
part 'arg_multi_action_controller.dart';
part 'arg_single_action_controller.dart';
part 'multi_action_controller.dart';
part 'single_action_controller.dart';

@immutable
abstract class Command {
  static const SingleActionProvider _droppable =
      SingleActionProvider._droppable();
  static const SingleActionProvider _restartable =
      SingleActionProvider._restartable();

  static const MultiActionProvider _sequential =
      MultiActionProvider._sequential();
  static const MultiActionProvider _concurrent =
      MultiActionProvider._concurrent();

  static const ArgCommandProvider _arg = ArgCommandProvider._();

  static const SingleActionProvider droppable = _droppable;
  static const SingleActionProvider restartable = _restartable;

  static const MultiActionProvider concurrent = _concurrent;
  static const MultiActionProvider sequential = _sequential;

  static const ArgCommandProvider arg = _arg;
}

@immutable
class ArgCommandProvider {
  const ArgCommandProvider._();

  static const ArgSingleActionProvider _droppable =
      ArgSingleActionProvider._droppable();
  static const ArgSingleActionProvider _restartable =
      ArgSingleActionProvider._restartable();
  static const ArgMultiActionProvider _sequential =
      ArgMultiActionProvider._sequential();
  static const ArgMultiActionProvider _concurrent =
      ArgMultiActionProvider._concurrent();

  ArgMultiActionProvider get concurrent => _concurrent;
  ArgMultiActionProvider get sequential => _sequential;

  ArgSingleActionProvider get droppable => _droppable;
  ArgSingleActionProvider get restartable => _restartable;
}

// Single Action

@immutable
class SingleActionProvider {
  const SingleActionProvider._droppable()
    : _strategy = ActionStrategy.droppable;

  const SingleActionProvider._restartable()
    : _strategy = ActionStrategy.restartable;

  final ActionStrategy _strategy;

  AutoDisposeStateNotifierProvider<SingleCommand<DataT>, AsyncState<DataT>>
  call<DataT>(Future<EitherResponse<DataT>?> Function(Ref ref) action) {
    return StateNotifierProvider.autoDispose<
      SingleCommand<DataT>,
      AsyncState<DataT>
    >((ref) {
      return SingleCommand(() => action(ref), strategy: _strategy);
    });
  }
}

@immutable
class ArgSingleActionProvider {
  const ArgSingleActionProvider._droppable()
    : _strategy = ActionStrategy.droppable;

  const ArgSingleActionProvider._restartable()
    : _strategy = ActionStrategy.restartable;

  final ActionStrategy _strategy;

  AutoDisposeStateNotifierProvider<
    SingleActionArgController<DataT, Arg>,
    SingleActionArgControllerState<DataT, Arg>
  >
  call<DataT, Arg extends Record>(
    Future<EitherResponse<DataT>?> Function(Ref ref, Arg arg) action,
  ) {
    return StateNotifierProvider.autoDispose<
      SingleActionArgController<DataT, Arg>,
      SingleActionArgControllerState<DataT, Arg>
    >(
      (ref) => SingleActionArgController(
        (arg) => action(ref, arg),
        strategy: _strategy,
      ),
    );
  }
}

// Multi Action

@immutable
class MultiActionProvider {
  const MultiActionProvider._concurrent()
    : _strategy = ActionStrategy.concurrent;

  const MultiActionProvider._sequential()
    : _strategy = ActionStrategy.sequential;

  final ActionStrategy _strategy;

  AutoDisposeStateNotifierProvider<
    MultiCommand<DataT>,
    MultiCommandState<DataT>
  >
  call<DataT>(Future<EitherResponse<DataT>?> Function(Ref ref) action) {
    return StateNotifierProvider.autoDispose<
      MultiCommand<DataT>,
      MultiCommandState<DataT>
    >((ref) => MultiCommand(() => action(ref), strategy: _strategy));
  }
}

@immutable
class ArgMultiActionProvider {
  const ArgMultiActionProvider._concurrent()
    : _strategy = ActionStrategy.concurrent;

  const ArgMultiActionProvider._sequential()
    : _strategy = ActionStrategy.sequential;

  final ActionStrategy _strategy;

  AutoDisposeStateNotifierProvider<
    ArgMultiCommand<DataT, Arg>,
    ArgMultiCommandState<DataT, Arg>
  >
  call<DataT, Arg extends Record>(
    Future<EitherResponse<DataT>?> Function(Ref ref, Arg arg) action,
  ) {
    return StateNotifierProvider.autoDispose<
      ArgMultiCommand<DataT, Arg>,
      ArgMultiCommandState<DataT, Arg>
    >((ref) => ArgMultiCommand((arg) => action(ref, arg), strategy: _strategy));
  }
}

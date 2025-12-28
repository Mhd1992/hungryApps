import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/controller/future_data_controller.dart';
import 'package:hungry/core/controller/stream_data_controller.dart';
import 'package:hungry/core/models/async_state.dart';
import 'package:hungry/core/models/paged_data_response.dart';
import 'package:hungry/core/models/response_failure.dart';
import 'package:hungry/core/networks/retrofit/model/base_response.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:async';
import '../paged_data/paged_data_controller.dart';

typedef FutureRepoResult<T> = Future<Either<ResponseFailure, T>?> Function();
typedef FutureDataResult<T> = Future<Either<ResponseFailure, T>> Function();
typedef StreamRepoResult<T> = Stream<Either<ResponseFailure, T>?> Function();
typedef StreamDataResult<T> = Stream<Either<ResponseFailure, T>> Function();

typedef AsyncStateNotifierProvider<T> =
    StateNotifierProvider<FutureDataController<T>, AsyncState<T>>;
typedef AsyncActionStateNotifierProvider<T> =
    AutoDisposeStateNotifierProvider<FutureDataController<T>, AsyncState<T>>;
typedef FamilyAsyncActionStateNotifierProvider<T, P> =
    AutoDisposeStateNotifierProviderFamily<
      FutureDataController<T>,
      AsyncState<T>,
      P
    >;
typedef StreamStateNotifierProvider<T> =
    StateNotifierProvider<StreamDataController<T>, AsyncState<T>>;

@immutable
abstract class DataProvider {
  /// Creates a [StateNotifierProvider] for handling [Future] operations.
  static AutoDisposeStateNotifierProvider<
    FutureDataController<T>,
    AsyncState<T>
  >
  future<T>(FutureDataResult<T> Function(Ref ref) fetcher) {
    return AutoDisposeStateNotifierProvider<
      FutureDataController<T>,
      AsyncState<T>
    >((ref) => FutureDataController<T>(() => fetcher(ref)()));
  }

  /// Creates a [StateNotifierProvider] for handling [Future] operations.
  static AutoDisposeStateNotifierProviderFamily<
    FutureDataController<T>,
    AsyncState<T>,
    Arg
  >
  futureFamily<T, Arg extends Record>(
    FutureDataResult<T> Function(Ref ref, Arg arg) fetcher,
  ) {
    return AutoDisposeStateNotifierProvider.family<
      FutureDataController<T>,
      AsyncState<T>,
      Arg
    >((ref, Arg arg) => FutureDataController<T>(() => fetcher(ref, arg)()));
  }

  /// Creates a [StateNotifierProvider] for handling [Stream] operations.
  static StreamStateNotifierProvider<T> stream<T>(
    StreamDataResult<T> Function(Ref ref) fetcher,
  ) {
    return StateNotifierProvider<StreamDataController<T>, AsyncState<T>>(
      (ref) => StreamDataController<T>(() => fetcher(ref)()),
    );
  }

  /// Creates a [StateNotifierProvider] for handling paged data [Future] operations.
  static AutoDisposeStateNotifierProvider<
    PagedDataController<T, DataViewT>,
    PagingState<int, DataViewT>
  >
  paged<T, DataViewT>(
    Future<Either<ResponseFailure, BaseResponse<PagedDataResponse<T>>>>
    Function()
    Function(Ref ref, int page)
    repo, {
    required List<DataViewT> Function(Ref ref, List<T> data) mapper,
    void Function(
      Ref ref,
      List<List<DataViewT>>? Function() getPages,
      void Function(List<List<DataViewT>> newState) update,
    )?
    handler,
  }) {
    return StateNotifierProvider.autoDispose<
      PagedDataController<T, DataViewT>,
      PagingState<int, DataViewT>
    >((ref) {
      final controller = PagedDataController<T, DataViewT>(
        (page) => repo(ref, page)(),
        mapper: (data) => mapper(ref, data),
      );
      handler?.call(ref, () => controller.state.pages, controller.update);
      return controller;
    });
  }

  static AutoDisposeStateNotifierProviderFamily<
    PagedDataController<T, DataViewT>,
    PagingState<int, DataViewT>,
    Arg
  >
  pagedFamily<T, DataViewT, Arg extends Record>(
    Future<Either<ResponseFailure, BaseResponse<PagedDataResponse<T>>>>
    Function()
    Function(Ref ref, int page, Arg arg)
    repo, {
    required List<DataViewT> Function(Ref ref, List<T> data) mapper,
  }) {
    return StateNotifierProvider.autoDispose.family<
      PagedDataController<T, DataViewT>,
      PagingState<int, DataViewT>,
      Arg
    >(
      (ref, arg) => PagedDataController<T, DataViewT>(
        (page) => repo(ref, page, arg)(),
        mapper: (data) => mapper(ref, data),
      ),
    );
  }

  static const controller = CustomControllerBuilder();
}

// abstract class DataProvider {
//   static AutoDisposeNotifierProvider<FutureDataControllerV2<DataT>,
//       AsyncState<DataT>> future<DataT>(
//           Future<Either<ResponseFailure, DataT>> Function() Function(
//                   Ref<Object?>)
//               repo) =>
//       NotifierProvider.autoDispose<FutureDataControllerV2<DataT>,
//           AsyncState<DataT>>(() => FutureDataControllerV2(repo));
// }

class CustomControllerBuilder {
  const CustomControllerBuilder();

  AutoDisposeNotifierProvider<ControllerT, AsyncState<DataT>>
  future<ControllerT extends FutureDataControllerV2<DataT>, DataT>(
    ControllerT Function() controller,
  ) => NotifierProvider.autoDispose<ControllerT, AsyncState<DataT>>(controller);
}

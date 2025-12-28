import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/models/paged_data_response.dart';
import 'package:hungry/core/models/response_failure.dart';
import 'package:hungry/core/networks/retrofit/model/base_response.dart';
import 'dart:async';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PagedDataController<DataT, DataViewT>
    extends StateNotifier<PagingState<int, DataViewT>> {
  PagedDataController(this._repo, {required this.mapper})
    : super(PagingState());

  final List<DataViewT> Function(List<DataT> data) mapper;

  final Future<Either<ResponseFailure, BaseResponse<PagedDataResponse<DataT>>>>
  Function(int page)
  _repo;

  void update(List<List<DataViewT>> newState) {
    state = state.copyWith(pages: newState);
  }

  Future<void> fetchNextPage() async {
    final s = state;
    if (s.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    final newPage = (state.keys?.last ?? 0) + 1;

    final response = await _repo(newPage);

    response.fold(
      (l) {
        state = state.copyWith(error: l, isLoading: false);
      },
      (newItems) {
        state = state.copyWith(
          hasNextPage: newItems.data!.hasMorePages,
          pages: [...?state.pages, mapper(newItems.data!.results)],
          keys: [...?state.keys, newPage],
          isLoading: false,
        );
      },
    );
  }

  Future<void> refresh() async {
    state = PagingState<int, DataViewT>();

    final newPage = (state.keys?.last ?? 0) + 1;

    final response = await _repo(newPage);

    response.fold(
      (l) {
        state = state.copyWith(error: l, isLoading: false);
      },
      (newItems) {
        state = state.copyWith(
          hasNextPage: newItems.data!.hasMorePages,
          pages: [...?state.pages, mapper(newItems.data!.results)],
          keys: [...?state.keys, newPage],
          isLoading: false,
        );
      },
    );
  }
}

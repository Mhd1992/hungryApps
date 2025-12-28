import 'package:hungry/core/networks/retrofit/model/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paged_data_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PagedDataResponse<T> {
  const PagedDataResponse({
    required this.results,
    required this.currentPage,
    required this.pageSize,
    required this.total,
    required this.lastPage,
  });

  @JsonKey(defaultValue: [])
  final List<T> results;
  final int currentPage;
  final int pageSize;
  final int total;
  final int lastPage;
  bool get hasMorePages => currentPage < lastPage;

  factory PagedDataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) => _$PagedDataResponseFromJson(json, fromJsonT);
}

extension PagedDataResponseX<T> on PagedDataResponse<T> {
  BaseResponse<PagedDataResponse<T>> toResponseModel() {
    return BaseResponse(data: this, message: '', code: 200);
  }

  PagedDataResponse<N> changeResults<N>(List<N> newResults) {
    return PagedDataResponse(
      results: newResults,
      currentPage: currentPage,
      pageSize: pageSize,
      total: total,
      lastPage: lastPage,
    );
  }
}

extension PagedDataResponseFutureX<T> on Future<PagedDataResponse<T>> {
  Future<BaseResponse<PagedDataResponse<T>>> toResponseModel() {
    return then((value) => value.toResponseModel());
  }
}

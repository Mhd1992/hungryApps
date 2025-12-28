import 'package:freezed_annotation/freezed_annotation.dart';
import 'response_failure.dart';

part 'async_state.freezed.dart';

@freezed
sealed class AsyncState<LoadedType> with _$AsyncState<LoadedType> {
  const factory AsyncState.init() = Init<LoadedType>;
  const factory AsyncState.loading() = Loading<LoadedType>;
  const factory AsyncState.loaded(LoadedType data) = Loaded<LoadedType>;
  const factory AsyncState.failure(ResponseFailure failure) =
      Failure<LoadedType>;

  const AsyncState._();

  bool get isLoading => this is Loading<LoadedType>;
  bool get isLoaded => this is Loaded<LoadedType>;
  bool get isFailure => this is Failure<LoadedType>;
  bool get isInit => this is Init<LoadedType>;

  LoadedType? get dataOrNull {
    switch (this) {
      case Loaded<LoadedType>(data: final data):
        return data;
      case _:
        return null;
    }
  }

  ResponseFailure? get failureOrNull {
    switch (this) {
      case Failure<LoadedType>(failure: final failure):
        return failure;
      case _:
        return null;
    }
  }
}

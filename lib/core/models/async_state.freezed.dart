// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'async_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AsyncState<LoadedType> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(LoadedType data) loaded,
    required TResult Function(ResponseFailure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(LoadedType data)? loaded,
    TResult? Function(ResponseFailure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(LoadedType data)? loaded,
    TResult Function(ResponseFailure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Init<LoadedType> value) init,
    required TResult Function(Loading<LoadedType> value) loading,
    required TResult Function(Loaded<LoadedType> value) loaded,
    required TResult Function(Failure<LoadedType> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Init<LoadedType> value)? init,
    TResult? Function(Loading<LoadedType> value)? loading,
    TResult? Function(Loaded<LoadedType> value)? loaded,
    TResult? Function(Failure<LoadedType> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Init<LoadedType> value)? init,
    TResult Function(Loading<LoadedType> value)? loading,
    TResult Function(Loaded<LoadedType> value)? loaded,
    TResult Function(Failure<LoadedType> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AsyncStateCopyWith<LoadedType, $Res> {
  factory $AsyncStateCopyWith(AsyncState<LoadedType> value,
          $Res Function(AsyncState<LoadedType>) then) =
      _$AsyncStateCopyWithImpl<LoadedType, $Res, AsyncState<LoadedType>>;
}

/// @nodoc
class _$AsyncStateCopyWithImpl<LoadedType, $Res,
        $Val extends AsyncState<LoadedType>>
    implements $AsyncStateCopyWith<LoadedType, $Res> {
  _$AsyncStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AsyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitImplCopyWith<LoadedType, $Res> {
  factory _$$InitImplCopyWith(_$InitImpl<LoadedType> value,
          $Res Function(_$InitImpl<LoadedType>) then) =
      __$$InitImplCopyWithImpl<LoadedType, $Res>;
}

/// @nodoc
class __$$InitImplCopyWithImpl<LoadedType, $Res>
    extends _$AsyncStateCopyWithImpl<LoadedType, $Res, _$InitImpl<LoadedType>>
    implements _$$InitImplCopyWith<LoadedType, $Res> {
  __$$InitImplCopyWithImpl(_$InitImpl<LoadedType> _value,
      $Res Function(_$InitImpl<LoadedType>) _then)
      : super(_value, _then);

  /// Create a copy of AsyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitImpl<LoadedType> extends Init<LoadedType> {
  const _$InitImpl() : super._();

  @override
  String toString() {
    return 'AsyncState<$LoadedType>.init()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitImpl<LoadedType>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(LoadedType data) loaded,
    required TResult Function(ResponseFailure failure) failure,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(LoadedType data)? loaded,
    TResult? Function(ResponseFailure failure)? failure,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(LoadedType data)? loaded,
    TResult Function(ResponseFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Init<LoadedType> value) init,
    required TResult Function(Loading<LoadedType> value) loading,
    required TResult Function(Loaded<LoadedType> value) loaded,
    required TResult Function(Failure<LoadedType> value) failure,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Init<LoadedType> value)? init,
    TResult? Function(Loading<LoadedType> value)? loading,
    TResult? Function(Loaded<LoadedType> value)? loaded,
    TResult? Function(Failure<LoadedType> value)? failure,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Init<LoadedType> value)? init,
    TResult Function(Loading<LoadedType> value)? loading,
    TResult Function(Loaded<LoadedType> value)? loaded,
    TResult Function(Failure<LoadedType> value)? failure,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class Init<LoadedType> extends AsyncState<LoadedType> {
  const factory Init() = _$InitImpl<LoadedType>;
  const Init._() : super._();
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<LoadedType, $Res> {
  factory _$$LoadingImplCopyWith(_$LoadingImpl<LoadedType> value,
          $Res Function(_$LoadingImpl<LoadedType>) then) =
      __$$LoadingImplCopyWithImpl<LoadedType, $Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<LoadedType, $Res>
    extends _$AsyncStateCopyWithImpl<LoadedType, $Res,
        _$LoadingImpl<LoadedType>>
    implements _$$LoadingImplCopyWith<LoadedType, $Res> {
  __$$LoadingImplCopyWithImpl(_$LoadingImpl<LoadedType> _value,
      $Res Function(_$LoadingImpl<LoadedType>) _then)
      : super(_value, _then);

  /// Create a copy of AsyncState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl<LoadedType> extends Loading<LoadedType> {
  const _$LoadingImpl() : super._();

  @override
  String toString() {
    return 'AsyncState<$LoadedType>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl<LoadedType>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(LoadedType data) loaded,
    required TResult Function(ResponseFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(LoadedType data)? loaded,
    TResult? Function(ResponseFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(LoadedType data)? loaded,
    TResult Function(ResponseFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Init<LoadedType> value) init,
    required TResult Function(Loading<LoadedType> value) loading,
    required TResult Function(Loaded<LoadedType> value) loaded,
    required TResult Function(Failure<LoadedType> value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Init<LoadedType> value)? init,
    TResult? Function(Loading<LoadedType> value)? loading,
    TResult? Function(Loaded<LoadedType> value)? loaded,
    TResult? Function(Failure<LoadedType> value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Init<LoadedType> value)? init,
    TResult Function(Loading<LoadedType> value)? loading,
    TResult Function(Loaded<LoadedType> value)? loaded,
    TResult Function(Failure<LoadedType> value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading<LoadedType> extends AsyncState<LoadedType> {
  const factory Loading() = _$LoadingImpl<LoadedType>;
  const Loading._() : super._();
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<LoadedType, $Res> {
  factory _$$LoadedImplCopyWith(_$LoadedImpl<LoadedType> value,
          $Res Function(_$LoadedImpl<LoadedType>) then) =
      __$$LoadedImplCopyWithImpl<LoadedType, $Res>;
  @useResult
  $Res call({LoadedType data});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<LoadedType, $Res>
    extends _$AsyncStateCopyWithImpl<LoadedType, $Res, _$LoadedImpl<LoadedType>>
    implements _$$LoadedImplCopyWith<LoadedType, $Res> {
  __$$LoadedImplCopyWithImpl(_$LoadedImpl<LoadedType> _value,
      $Res Function(_$LoadedImpl<LoadedType>) _then)
      : super(_value, _then);

  /// Create a copy of AsyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$LoadedImpl<LoadedType>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as LoadedType,
    ));
  }
}

/// @nodoc

class _$LoadedImpl<LoadedType> extends Loaded<LoadedType> {
  const _$LoadedImpl(this.data) : super._();

  @override
  final LoadedType data;

  @override
  String toString() {
    return 'AsyncState<$LoadedType>.loaded(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl<LoadedType> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of AsyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<LoadedType, _$LoadedImpl<LoadedType>> get copyWith =>
      __$$LoadedImplCopyWithImpl<LoadedType, _$LoadedImpl<LoadedType>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(LoadedType data) loaded,
    required TResult Function(ResponseFailure failure) failure,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(LoadedType data)? loaded,
    TResult? Function(ResponseFailure failure)? failure,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(LoadedType data)? loaded,
    TResult Function(ResponseFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Init<LoadedType> value) init,
    required TResult Function(Loading<LoadedType> value) loading,
    required TResult Function(Loaded<LoadedType> value) loaded,
    required TResult Function(Failure<LoadedType> value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Init<LoadedType> value)? init,
    TResult? Function(Loading<LoadedType> value)? loading,
    TResult? Function(Loaded<LoadedType> value)? loaded,
    TResult? Function(Failure<LoadedType> value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Init<LoadedType> value)? init,
    TResult Function(Loading<LoadedType> value)? loading,
    TResult Function(Loaded<LoadedType> value)? loaded,
    TResult Function(Failure<LoadedType> value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded<LoadedType> extends AsyncState<LoadedType> {
  const factory Loaded(final LoadedType data) = _$LoadedImpl<LoadedType>;
  const Loaded._() : super._();

  LoadedType get data;

  /// Create a copy of AsyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<LoadedType, _$LoadedImpl<LoadedType>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<LoadedType, $Res> {
  factory _$$FailureImplCopyWith(_$FailureImpl<LoadedType> value,
          $Res Function(_$FailureImpl<LoadedType>) then) =
      __$$FailureImplCopyWithImpl<LoadedType, $Res>;
  @useResult
  $Res call({ResponseFailure failure});

  $ResponseFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$FailureImplCopyWithImpl<LoadedType, $Res>
    extends _$AsyncStateCopyWithImpl<LoadedType, $Res,
        _$FailureImpl<LoadedType>>
    implements _$$FailureImplCopyWith<LoadedType, $Res> {
  __$$FailureImplCopyWithImpl(_$FailureImpl<LoadedType> _value,
      $Res Function(_$FailureImpl<LoadedType>) _then)
      : super(_value, _then);

  /// Create a copy of AsyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$FailureImpl<LoadedType>(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as ResponseFailure,
    ));
  }

  /// Create a copy of AsyncState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResponseFailureCopyWith<$Res> get failure {
    return $ResponseFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$FailureImpl<LoadedType> extends Failure<LoadedType> {
  const _$FailureImpl(this.failure) : super._();

  @override
  final ResponseFailure failure;

  @override
  String toString() {
    return 'AsyncState<$LoadedType>.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl<LoadedType> &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of AsyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<LoadedType, _$FailureImpl<LoadedType>> get copyWith =>
      __$$FailureImplCopyWithImpl<LoadedType, _$FailureImpl<LoadedType>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(LoadedType data) loaded,
    required TResult Function(ResponseFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(LoadedType data)? loaded,
    TResult? Function(ResponseFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(LoadedType data)? loaded,
    TResult Function(ResponseFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Init<LoadedType> value) init,
    required TResult Function(Loading<LoadedType> value) loading,
    required TResult Function(Loaded<LoadedType> value) loaded,
    required TResult Function(Failure<LoadedType> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Init<LoadedType> value)? init,
    TResult? Function(Loading<LoadedType> value)? loading,
    TResult? Function(Loaded<LoadedType> value)? loaded,
    TResult? Function(Failure<LoadedType> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Init<LoadedType> value)? init,
    TResult Function(Loading<LoadedType> value)? loading,
    TResult Function(Loaded<LoadedType> value)? loaded,
    TResult Function(Failure<LoadedType> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class Failure<LoadedType> extends AsyncState<LoadedType> {
  const factory Failure(final ResponseFailure failure) =
      _$FailureImpl<LoadedType>;
  const Failure._() : super._();

  ResponseFailure get failure;

  /// Create a copy of AsyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<LoadedType, _$FailureImpl<LoadedType>> get copyWith =>
      throw _privateConstructorUsedError;
}

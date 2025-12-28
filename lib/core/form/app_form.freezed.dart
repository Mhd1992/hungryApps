// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FormControllerState<DataT> {
  AsyncState<DataT> get response => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  void Function()? get clearAll => throw _privateConstructorUsedError;

  /// Create a copy of FormControllerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormControllerStateCopyWith<DataT, FormControllerState<DataT>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormControllerStateCopyWith<DataT, $Res> {
  factory $FormControllerStateCopyWith(FormControllerState<DataT> value,
          $Res Function(FormControllerState<DataT>) then) =
      _$FormControllerStateCopyWithImpl<DataT, $Res,
          FormControllerState<DataT>>;
  @useResult
  $Res call(
      {AsyncState<DataT> response, String? error, void Function()? clearAll});

  $AsyncStateCopyWith<DataT, $Res> get response;
}

/// @nodoc
class _$FormControllerStateCopyWithImpl<DataT, $Res,
        $Val extends FormControllerState<DataT>>
    implements $FormControllerStateCopyWith<DataT, $Res> {
  _$FormControllerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormControllerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? error = freezed,
    Object? clearAll = freezed,
  }) {
    return _then(_value.copyWith(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as AsyncState<DataT>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      clearAll: freezed == clearAll
          ? _value.clearAll
          : clearAll // ignore: cast_nullable_to_non_nullable
              as void Function()?,
    ) as $Val);
  }

  /// Create a copy of FormControllerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AsyncStateCopyWith<DataT, $Res> get response {
    return $AsyncStateCopyWith<DataT, $Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FormControllerStateImplCopyWith<DataT, $Res>
    implements $FormControllerStateCopyWith<DataT, $Res> {
  factory _$$FormControllerStateImplCopyWith(
          _$FormControllerStateImpl<DataT> value,
          $Res Function(_$FormControllerStateImpl<DataT>) then) =
      __$$FormControllerStateImplCopyWithImpl<DataT, $Res>;
  @override
  @useResult
  $Res call(
      {AsyncState<DataT> response, String? error, void Function()? clearAll});

  @override
  $AsyncStateCopyWith<DataT, $Res> get response;
}

/// @nodoc
class __$$FormControllerStateImplCopyWithImpl<DataT, $Res>
    extends _$FormControllerStateCopyWithImpl<DataT, $Res,
        _$FormControllerStateImpl<DataT>>
    implements _$$FormControllerStateImplCopyWith<DataT, $Res> {
  __$$FormControllerStateImplCopyWithImpl(
      _$FormControllerStateImpl<DataT> _value,
      $Res Function(_$FormControllerStateImpl<DataT>) _then)
      : super(_value, _then);

  /// Create a copy of FormControllerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? error = freezed,
    Object? clearAll = freezed,
  }) {
    return _then(_$FormControllerStateImpl<DataT>(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as AsyncState<DataT>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      clearAll: freezed == clearAll
          ? _value.clearAll
          : clearAll // ignore: cast_nullable_to_non_nullable
              as void Function()?,
    ));
  }
}

/// @nodoc

class _$FormControllerStateImpl<DataT> implements _FormControllerState<DataT> {
  const _$FormControllerStateImpl(
      {this.response = const Init(), this.error, this.clearAll});

  @override
  @JsonKey()
  final AsyncState<DataT> response;
  @override
  final String? error;
  @override
  final void Function()? clearAll;

  @override
  String toString() {
    return 'FormControllerState<$DataT>(response: $response, error: $error, clearAll: $clearAll)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormControllerStateImpl<DataT> &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.clearAll, clearAll) ||
                other.clearAll == clearAll));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response, error, clearAll);

  /// Create a copy of FormControllerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormControllerStateImplCopyWith<DataT, _$FormControllerStateImpl<DataT>>
      get copyWith => __$$FormControllerStateImplCopyWithImpl<DataT,
          _$FormControllerStateImpl<DataT>>(this, _$identity);
}

abstract class _FormControllerState<DataT>
    implements FormControllerState<DataT> {
  const factory _FormControllerState(
      {final AsyncState<DataT> response,
      final String? error,
      final void Function()? clearAll}) = _$FormControllerStateImpl<DataT>;

  @override
  AsyncState<DataT> get response;
  @override
  String? get error;
  @override
  void Function()? get clearAll;

  /// Create a copy of FormControllerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormControllerStateImplCopyWith<DataT, _$FormControllerStateImpl<DataT>>
      get copyWith => throw _privateConstructorUsedError;
}

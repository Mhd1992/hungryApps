part of 'app_form.dart';

@freezed
abstract class FormControllerState<DataT> with _$FormControllerState<DataT> {
  const factory FormControllerState({
    @Default(Init()) AsyncState<DataT> response,
    String? error,
    void Function()? clearAll,
  }) = _FormControllerState<DataT>;
}

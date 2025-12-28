part of 'provider.dart';

typedef ManualFormControllerRef<DataT> = Ref<FormControllerState<DataT>>;

typedef ManualFormNotifierProvider<
  DataT,
  ControllerT extends ManualFormController<DataT>
> = AutoDisposeStateNotifierProvider<ControllerT, FormControllerState<DataT>>;

// Auto Form typedef

typedef AutoFormNotifierProvider<
  DataT,
  ControllerT extends AutoFormController<DataT>
> = AutoDisposeStateNotifierProvider<ControllerT, FormControllerState<DataT>>;

typedef AutoFormControllerRef<DataT> = Ref<FormControllerState<DataT>>;

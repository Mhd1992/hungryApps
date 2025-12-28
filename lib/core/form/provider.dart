import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/models/async_state.dart';
import 'package:hungry/core/provider/data_controllers_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'app_form.dart';

part 'types.dart';

abstract class FormControllerProvider {
  static final family = _FormControllerFamilyProvider();

  static AutoFormNotifierProvider<DataT, ControllerT>
  auto<DataT, ControllerT extends AutoFormController<DataT>>(
    FutureDataResult<DataT> Function(AutoFormControllerRef<DataT> ref)
    fetcher, {
    required FormGroup Function(AutoFormControllerRef<DataT> ref) formGroup,
    ControllerT Function()? extendedController,
    bool? disableSubmitWhenFormInvalid,
  }) {
    return StateNotifierProvider.autoDispose<
      ControllerT,
      FormControllerState<DataT>
    >((ref) {
      final contr =
          extendedController?.call() ??
          AutoFormController<DataT>(
                disableSubmitWhenFormInvalid: disableSubmitWhenFormInvalid,
              )
              as ControllerT;

      // ignore: invalid_use_of_protected_member
      contr.ref = ref;

      // ignore: invalid_use_of_protected_member
      contr.request = () => fetcher(ref)();

      final group = formGroup.call(ref);
      // ignore: invalid_use_of_protected_member
      contr.init(group);

      return contr;
    });
  }

  static ManualFormNotifierProvider<DataT, ControllerT>
  manual<DataT, ControllerT extends ManualFormController<DataT>>(
    FutureDataResult<DataT> Function(ManualFormControllerRef<DataT> ref)
    fetcher, {
    required FormGroup Function(ManualFormControllerRef<DataT> ref) formGroup,
    ControllerT Function()? extendedController,
    bool? disableSubmitWhenFormInvalid,
  }) {
    return StateNotifierProvider.autoDispose<
      ControllerT,
      FormControllerState<DataT>
    >((ref) {
      final contr =
          extendedController?.call() ??
          ManualFormController<DataT>(
                disableSubmitWhenFormInvalid: disableSubmitWhenFormInvalid,
              )
              as ControllerT;

      // ignore: invalid_use_of_protected_member
      contr.ref = ref;

      // ignore: invalid_use_of_protected_member
      contr.request = () => fetcher(ref)();

      final group = formGroup.call(ref);
      // ignore: invalid_use_of_protected_member
      contr.init(group);

      return contr;
    });
  }

  static ManualFormNotifierProvider<DataT, ControllerT>
  sneak<DataT, ControllerT extends ManualFormController<DataT>>({
    void Function(ManualFormControllerRef<DataT> ref)? onSubmit,
    required FormGroup Function(ManualFormControllerRef<DataT> ref) formGroup,
    ControllerT Function()? extendedController,
    bool? disableSubmitWhenFormInvalid,
  }) {
    return StateNotifierProvider.autoDispose<
      ControllerT,
      FormControllerState<DataT>
    >((ref) {
      final contr =
          extendedController?.call() ??
          ManualFormController<DataT>(
                disableSubmitWhenFormInvalid: disableSubmitWhenFormInvalid,
              )
              as ControllerT;

      // ignore: invalid_use_of_protected_member
      contr.ref = ref;

      // ignore: invalid_use_of_protected_member
      contr.request = () => null;

      final group = formGroup.call(ref);
      // ignore: invalid_use_of_protected_member
      contr.init(group);

      return contr;
    });
  }
}

class _FormControllerFamilyProvider {
  AutoDisposeStateNotifierProviderFamily<
    ControllerT,
    FormControllerState<DataT>,
    Arg
  >
  auto<
    DataT,
    ControllerT extends AutoFormController<DataT>,
    Arg extends Record
  >(
    FutureDataResult<DataT> Function(AutoFormControllerRef<DataT> ref, Arg arg)
    fetcher, {
    required FormGroup Function(AutoFormControllerRef<DataT> ref, Arg arg)
    formGroup,
    ControllerT Function()? extendedController,
    bool? disableSubmitWhenFormInvalid,
  }) {
    return StateNotifierProvider.family
        .autoDispose<ControllerT, FormControllerState<DataT>, Arg>((ref, arg) {
          final contr =
              extendedController?.call() ??
              AutoFormController<DataT>(
                    disableSubmitWhenFormInvalid: disableSubmitWhenFormInvalid,
                  )
                  as ControllerT;

          // ignore: invalid_use_of_protected_member
          contr.ref = ref;

          // ignore: invalid_use_of_protected_member
          contr.request = () => fetcher(ref, arg)();

          final group = formGroup.call(ref, arg);
          // ignore: invalid_use_of_protected_member
          contr.init(group);

          return contr;
        });
  }

  AutoDisposeStateNotifierProviderFamily<
    ControllerT,
    FormControllerState<DataT>,
    Arg
  >
  manual<
    DataT,
    ControllerT extends ManualFormController<DataT>,
    Arg extends Record
  >(
    FutureDataResult<DataT> Function(
      ManualFormControllerRef<DataT> ref,
      Arg arg,
    )
    fetcher, {
    required FormGroup Function(ManualFormControllerRef<DataT> ref, Arg arg)
    formGroup,
    ControllerT Function()? extendedController,
    bool? disableSubmitWhenFormInvalid,
  }) {
    return StateNotifierProvider.family
        .autoDispose<ControllerT, FormControllerState<DataT>, Arg>((ref, arg) {
          final contr =
              extendedController?.call() ??
              ManualFormController<DataT>(
                    disableSubmitWhenFormInvalid: disableSubmitWhenFormInvalid,
                  )
                  as ControllerT;

          // ignore: invalid_use_of_protected_member
          contr.ref = ref;

          // ignore: invalid_use_of_protected_member
          contr.request = () => fetcher(ref, arg)();

          final group = formGroup.call(ref, arg);
          // ignore: invalid_use_of_protected_member
          contr.init(group);

          return contr;
        });
  }

  AutoDisposeStateNotifierProviderFamily<
    ControllerT,
    FormControllerState<DataT>,
    Arg
  >
  sneak<
    DataT,
    ControllerT extends ManualFormController<DataT>,
    Arg extends Record
  >({
    required FormGroup Function(ManualFormControllerRef<DataT> ref, Arg arg)
    formGroup,
    ControllerT Function()? extendedController,
    bool? disableSubmitWhenFormInvalid,
  }) {
    return StateNotifierProvider.family
        .autoDispose<ControllerT, FormControllerState<DataT>, Arg>((ref, arg) {
          final contr =
              extendedController?.call() ??
              ManualFormController<DataT>(
                    disableSubmitWhenFormInvalid: disableSubmitWhenFormInvalid,
                  )
                  as ControllerT;

          // ignore: invalid_use_of_protected_member
          contr.ref = ref;

          // ignore: invalid_use_of_protected_member
          contr.request = () => null;

          final group = formGroup.call(ref, arg);
          // ignore: invalid_use_of_protected_member
          contr.init(group);

          return contr;
        });
  }
}

extension FormProviderRefEX<T> on Ref<FormControllerState<T>> {
  /// This method listens to changes in the provider's response state
  /// and executes the provided callback when the response is loaded.
  void onLoadedSelf(void Function(T response) callback) {
    listenSelf((previousState, newState) {
      // Skip if the response hasn't changed
      if (previousState?.response == newState.response) return;
      // Skip if the response is not loaded
      if (!newState.response.isLoaded) return;

      // Execute the callback with the new response
      callback(newState.response.dataOrNull as T);
    });
  }

  void onResponseSelf(void Function(AsyncState<T> state) callback) {
    listenSelf((previousState, newState) {
      // Skip if the response hasn't changed
      if (previousState?.response == newState.response) return;

      callback(newState.response);
    });
  }
}

extension XFormProviderRefEX<T> on Ref<FormControllerState<T>> {
  void onLoaded<M>(
    ProviderListenable<FormControllerState<M>> provider,
    void Function(M response) callback,
  ) {
    listen(provider, (previousState, newState) {
      // Skip if the response hasn't changed
      if (previousState?.response == newState.response) return;
      // Skip if the response is not loaded
      if (!newState.response.isLoaded) return;

      // Execute the callback with the new response
      callback(newState.response.dataOrNull as M);
    });
  }

  void onResponse<M>(
    ProviderListenable<FormControllerState<M>> provider,
    void Function(AsyncState<M> state) callback,
  ) {
    listen(provider, (previousState, newState) {
      // Skip if the response hasn't changed
      if (previousState?.response == newState.response) return;
      callback(newState.response);
    });
  }
}

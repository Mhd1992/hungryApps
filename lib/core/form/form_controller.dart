part of 'app_form.dart';

abstract class TryAgain {
  void tryAgain();
}

abstract class BaseFormController<DataT>
    extends StateNotifier<FormControllerState<DataT>>
    implements TryAgain {
  BaseFormController({bool? disableSubmitWhenFormInvalid})
    : disableSubmitWhenFormInvalid = disableSubmitWhenFormInvalid ?? true,
      super(FormControllerState<DataT>());

  final bool disableSubmitWhenFormInvalid;

  final List<StreamSubscription> _streamSubscriptions = [];

  @protected
  void init(FormGroup form) {
    _fromGroup = form;

    _streamSubscriptions.add(
      form.valueChanged.listen((value) {
        if (_isFormFilled && !state.response.isLoading) {
          state = state.copyWith(clearAll: _clearAll);
        } else {
          state = state.copyWith(clearAll: null);
        }
      }),
    );
  }

  @protected
  late final FutureResponse<DataT>? Function() request;

  FormGroup? _fromGroup;

  FormGroup get form => _fromGroup!;

  AbstractControl<dynamic> control(String name) => form.control(name);

  StreamSubscription<Map<String, Object?>?>? _onFormValueChangedSubs;
  StreamSubscription? _onControlChangedSubscription;

  void onFormValueChanged(void Function(Map<String, Object?>?)? onData) {
    _onFormValueChangedSubs ?? form.valueChanged.listen(onData);
  }

  void onControlValueChanged<T>(
    AppFormControl<T> control,
    void Function(T data) onData,
  ) {
    _onControlChangedSubscription ??
        control.valueChanges.listen((value) {
          onData.call(value as T);
        });
  }

  void resetControls(List<String>? names) {
    if (names == null) return;
    for (var name in names) {
      form.control(name).reset();
    }
  }

  void resetResponse() {
    state = state.copyWith(response: const Init());
  }

  void resetForm() => _clearAll();

  bool get _canMakeRequest => form.valid;

  Map<String, Object?> get value => form.value;

  bool get _isFormFilled => form.controls.values.any(
    (control) => control.value != null && control.value != '',
  );

  void _clearAll() {
    form.reset();
    state = state.copyWith(clearAll: null);
  }

  void _setErrors() {
    AbstractControl<dynamic>? firstInvalidField;
    switch (state.response) {
      case Failure(failure: final failure):
        state = state.copyWith(error: failure.errorMessage);
        switch (failure) {
          case BadRequest(validation: final value):
            value.errors.forEach((key, errors) {
              if (errors.isEmpty) return;
              final control = form.control(key);
              control.setErrors({errors.first: errors.first});
              firstInvalidField ??= control;
              control.markAsTouched();
            });
          case _:
            break;
        }
      case _:
        break;
    }
    firstInvalidField?.focus();
  }

  @override
  void dispose() {
    for (var subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    _onControlChangedSubscription?.cancel();
    _onFormValueChangedSubs?.cancel();
    super.dispose();
  }
}

class ManualFormController<DataT> extends BaseFormController<DataT> {
  ManualFormController({super.disableSubmitWhenFormInvalid});

  @protected
  late final Ref<FormControllerState<DataT>> ref;

  /// Manually submit the form
  void submit() async {
    if (state.response.isLoading) return;

    form.unfocus(touched: false);
    form.markAllAsTouched();
    state = state.copyWith(error: null);

    if (_canMakeRequest) {
      state = state.copyWith(response: const Loading());
      form.markAsDisabled(emitEvent: false);

      final result = await request();

      form.markAsUntouched();
      form.markAsEnabled(emitEvent: false);
      form.markAllAsTouched();

      if (result == null) {
        state = state.copyWith(response: const Init());
      } else {
        state = result.fold(
          (error) {
            return state.copyWith(response: Failure(error));
          },
          (response) {
            form.markAsUntouched();
            return state.copyWith(response: Loaded<DataT>(response));
          },
        );
      }

      _setErrors();
    }
  }

  @override
  void tryAgain() => submit();
}

class AutoFormController<DataT> extends BaseFormController<DataT> {
  AutoFormController({super.disableSubmitWhenFormInvalid});

  @protected
  late final Ref<FormControllerState<DataT>> ref;

  StreamSubscription? _streamSubscription;
  StreamSubscription? _xstreamSubscription;
  ConcurrentController<DataT, ()>? _controller;

  @override
  void init(FormGroup form) {
    super.init(form);
    _setupAutoSubmit();
  }

  /// Set up auto-submit logic
  void _setupAutoSubmit() {
    _controller = ConcurrentController<DataT, ()>(
      repo: (_) => request()!,
      strategy: ActionStrategy.restartable,
      debounceBeforeRequrest: const Duration(milliseconds: 500),
    );

    _xstreamSubscription = _controller?.stream.listen((event) {
      final asyncState = event.data;
      switch (asyncState) {
        case Init():
          break;
        case _:
          state = state.copyWith(response: asyncState);
      }
    });

    _streamSubscription = form.valueChanges.listen((_) {
      _makeRequest();
    });
  }

  void _makeRequest() {
    if (_canMakeRequest) {
      _controller?.fire(());
    }
  }

  void retry() => _makeRequest();

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _xstreamSubscription?.cancel();
    _controller?.close();
    super.dispose();
  }

  @override
  void tryAgain() => retry();
}

extension FormGroupExtension on FormGroup {
  Stream<Map<String, Object?>?> get valueChanged {
    const deepEq = DeepCollectionEquality();
    Map<String, Object?>? old;
    return valueChanges.where((_) {
      final newValue = value;
      if (!deepEq.equals(old, newValue)) {
        old = newValue;
        return true;
      }
      return false;
    });
  }
}

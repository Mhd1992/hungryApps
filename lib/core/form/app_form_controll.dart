import 'package:reactive_forms/reactive_forms.dart';

class AppFormControl<DataT> {
  AppFormControl(this.name, {FormControl<DataT>? control})
    : control = control ?? FormControl<DataT>();

  AppFormControl.required(this.name)
    : control = FormControl<DataT>(validators: [Validators.required]);

  AppFormControl.value(this.name, {required DataT value})
    : control = FormControl<DataT>(value: value);

  final String name;
  final FormControl<DataT> control;

  bool get disabled => control.disabled;

  bool get valid => control.valid;

  DataT? get value => control.value;

  set value(DataT? value) => control.value = value;

  Stream<DataT?> get valueChanges => control.valueChanges;

  void clearValidators() => control.clearValidators();

  void focus() => control.focus();

  void markAsEnabled({bool updateParent = true, bool emitEvent = true}) =>
      control.markAsEnabled(updateParent: updateParent, emitEvent: emitEvent);

  void reset({
    DataT? value,
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) => control.reset(
    value: value,
    updateParent: updateParent,
    emitEvent: emitEvent,
    removeFocus: removeFocus,
    disabled: disabled,
  );

  void setValidators(
    List<Validator<dynamic>> validators, {
    bool autoValidate = false,
    bool updateParent = true,
    bool emitEvent = true,
  }) => control.setValidators(
    validators,
    autoValidate: autoValidate,
    updateParent: updateParent,
    emitEvent: emitEvent,
  );

  void updateValue(
    DataT? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) => control.updateValue(
    value,
    updateParent: updateParent,
    emitEvent: emitEvent,
  );

  void updateValueAndValidity({
    bool updateParent = true,
    bool emitEvent = true,
  }) => control.updateValueAndValidity(
    updateParent: updateParent,
    emitEvent: emitEvent,
  );
}

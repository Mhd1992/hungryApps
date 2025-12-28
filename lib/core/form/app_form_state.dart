part of 'app_form.dart';

class AppFormState {
  const AppFormState({required this.dirty, required this.valid});

  final bool dirty;
  final bool valid;

  static AppFormState fromGroup(FormGroup formGroup) {
    return AppFormState(dirty: formGroup.dirty, valid: formGroup.valid);
  }
}

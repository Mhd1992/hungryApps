import 'dart:async';

import 'package:hungry/core/controller/action_controller/action_controllers.dart';
import 'package:hungry/core/controller/action_controller/single_currency_controller.dart';
import 'package:hungry/core/form/provider.dart';
import 'package:hungry/core/provider/repo_providers.dart';

import '../models/async_state.dart';
import '../models/response_failure.dart';
import '../utils/exported_file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_form_controll.dart';
part 'app_form.freezed.dart';
part 'app_form_state.dart';
part 'form_controller.dart';
part 'form_controller_state.dart';

typedef AnisFormBuilder = Widget Function(BuildContext context);

typedef AnisFromGroupBuilder =
    Widget Function(BuildContext context, AppFormState state);

class AnisForm<DataT> extends ConsumerWidget {
  const AnisForm({
    super.key,
    required this.provider,
    required AnisFormBuilder this.builder,
  }) : groupBuilder = null;

  const AnisForm.withState({
    super.key,
    required this.provider,
    required AnisFromGroupBuilder builder,
  }) : builder = null,
       groupBuilder = builder;

  final AnisFormBuilder? builder;

  final AnisFromGroupBuilder? groupBuilder;

  final AutoDisposeStateNotifierProvider<
    BaseFormController<DataT>,
    FormControllerState<DataT>
  >
  provider;

  static InheritedAnisForm? of(BuildContext context) {
    return context.getInheritedWidgetOfExactType<InheritedAnisForm>();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(provider, (p, n) {
      if (p?.response != n.response) {
        switch (n.response) {
          case Failure(failure: final failure):
            final msg = failure.errorMessage ?? 'something_went_wrong';
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(msg)));
          case _:
            break;
        }
      }
    });

    final controller = ref.watch(provider.notifier);

    final builder =
        this.builder?.call(context) ??
        groupBuilder?.call(context, controller.form.state);

    final child = ReactiveForm(
      formGroup: controller.form,
      child: Builder(builder: (context) => builder!),
    );

    if (controller is ManualFormController<DataT>) {
      return InheritedAnisForm(
        provider: provider as ManualFormNotifierProvider,
        child: Builder(builder: (context) => child),
      );
    }

    return child;
  }
}

extension on FormGroup {
  AppFormState get state => AppFormState.fromGroup(this);
}

class InheritedAnisForm extends InheritedWidget {
  const InheritedAnisForm({
    super.key,
    required this.provider,
    required super.child,
  });

  final AutoDisposeStateNotifierProvider<
    ManualFormController,
    FormControllerState
  >
  provider;

  @override
  bool updateShouldNotify(InheritedAnisForm oldWidget) =>
      oldWidget.provider != provider;
}

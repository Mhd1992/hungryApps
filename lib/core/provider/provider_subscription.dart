import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

ProviderSubscription<T> listenManualSafe<T>(
  WidgetRef ref,
  ProviderListenable<T> provider,
  void Function(T? previous, T next) listener,
) {
  return ref.listenManual<T>(provider, listener);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension ActionExtension on WidgetRef {
  T action<T>(ProviderListenable<T> provider) => watch(provider);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/data/repositories/products/side_options/side_options_repo.dart';

final sideOptionProvider = Provider<SideOptionRepo>(
  (ref) => SideOptionRepo(ref),
);

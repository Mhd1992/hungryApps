import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/features/auth/data/repository/v1/auth_repo_v1.dart';
import 'package:hungry/core/utils/exported_file.dart';

final userProvider = StateProvider.autoDispose<AsyncValue<UserModel?>>(
  (ref) => AsyncValue.loading(),
);

Future<void> getProfileData(WidgetRef ref, {bool updatedData = false}) async {
  AuthRepoV1 authRepo = AuthRepoV1();
  try {
    final user = await authRepo.profile(updatedData: updatedData);
    ref.read(userProvider.notifier).state = AsyncValue.data(user);
  } catch (e) {
    if (!ref.context.mounted) return;
    ref.read(userProvider.notifier).state = AsyncValue.error(
      e.toString(),
      StackTrace.current,
    );
  }
}

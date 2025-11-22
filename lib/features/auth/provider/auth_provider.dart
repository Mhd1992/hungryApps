import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/features/auth/data/repository/v1/auth_repo_v1.dart';
import 'package:hungry/core/utils/exported_file.dart';

final userProvider = StateProvider.autoDispose<AsyncValue<UserModel?>>(
  (ref) => AsyncValue.loading(),
);

final loadingState = StateProvider.autoDispose((ref) => false);

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

Future<void> refreshUserProvider(WidgetRef ref) async {
  final current = ref.read(userProvider);

  // If data doesn't exist, do nothing
  if (current.value == null) return;

  // Reload fresh data from API
  await getProfileData(ref, updatedData: true);
}

Future<void> updateProfileData(
  WidgetRef ref, {
  required String name,
  required String email,
  required String address,
  String? imagePath,
  String? visa,
}) async {
  AuthRepoV1 authRepo = AuthRepoV1();
  try {
    ref.read(loadingState.notifier).state = true;
    final user = await authRepo.editProfile(
      name: name,
      email: email,
      address: address,
      imagePath: imagePath,
      visa: visa,
    );
    ref.read(userProvider.notifier).state = AsyncValue.data(user);
    ref.read(loadingState.notifier).state = false;
  } catch (e) {
    if (!ref.context.mounted) return;
    ref.read(userProvider.notifier).state = AsyncValue.error(
      e.toString(),
      StackTrace.current,
    );
  } finally {
    ref.read(loadingState.notifier).state = false;
  }
}

import 'package:hungry/core/utils/exported_file.dart';

final userProvider = StateProvider.autoDispose<AsyncValue<UserModel?>>(
  (ref) => AsyncValue.loading(),
);

final loadingState = StateProvider.autoDispose((ref) => false);
final logoutLoading = StateProvider.autoDispose((ref) => false);
final selectedImageProvider = StateProvider.autoDispose<String?>((ref) => null);

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

Future<void> logout(WidgetRef ref) async {
  try {
    AuthRepoV1 authRepo = AuthRepoV1();
    ref.read(logoutLoading.notifier).state = true;
    await authRepo.logout();

    if (ref.context.mounted) {
      Navigator.of(ref.context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  } catch (e) {
    String errorMessage = 'unknown Error';
    if (e is ApiError) {
      errorMessage = e.message;
      if (ref.context.mounted) {
        ref.context.showSnackBar(errorMessage);
      }
    }
  } finally {
    ref.read(logoutLoading.notifier).state = false;
  }
}

Future<void> uploadImage(WidgetRef ref) async {
  final pickedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  if (pickedImage != null) {
    ref.read(selectedImageProvider.notifier).state = pickedImage.path;
  }
}

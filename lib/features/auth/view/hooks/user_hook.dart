import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/networks/dio_client.dart';
import '../../../../core/utils/pref_helpers.dart';
import '../../../../update_features/user/data/user_api.dart';
import '../../../../update_features/user/data/user_model.dart';
import '../../../../update_features/user/data/user_repo.dart';

/// Result of [useProfile]. All state is held in hooks so the UI rebuilds
/// when [user], [loading], [error], [isUpdating], [selectedImage], or [isGuest] change.
class UseProfileHook {
  final UserModel? user;
  final bool loading;
  final String? error;
  final bool isUpdating;
  final bool isLoggingOut;
  final bool isGuest;
  final String? selectedImage;
  final Future<void> Function() refresh;
  final Future<void> Function(UserModel updatedUser) updateUser;
  final Future<void> Function() uploadImage;
  final void Function(void Function() onSuccess) logout;

  const UseProfileHook({
    required this.user,
    required this.loading,
    required this.error,
    required this.isUpdating,
    required this.isLoggingOut,
    required this.isGuest,
    required this.selectedImage,
    required this.refresh,
    required this.updateUser,
    required this.uploadImage,
    required this.logout,
  });
}

UseProfileHook useProfile(BuildContext context) {
  final user = useState<UserModel?>(null);
  final loading = useState<bool>(true);
  final error = useState<String?>(null);
  final isUpdating = useState<bool>(false);
  final isLoggingOut = useState<bool>(false);
  final isGuest = useState<bool>(false);
  final selectedImage = useState<String?>(null);

  final repo = useMemoized(() {
    final dioClient = DioClient();
    final api = UserApi(dioClient.dio);
    return UserRepo(api);
  });

  Future<void> fetchUser() async {
    if (user.value != null) return; //prevent reload
    if (!context.mounted) return;
    loading.value = true;
    error.value = null;
    try {
      final result = await repo.getProfile();
      if (context.mounted) user.value = result;
    } catch (e) {
      if (context.mounted) error.value = e.toString();
    }
    if (context.mounted) loading.value = false;
  }

  Future<void> updateUserProfile(UserModel updatedUser) async {
    if (!context.mounted) return;
    isUpdating.value = true;
    try {
      final result = await repo.updateUserData(updatedUser);
      if (context.mounted) {
        user.value = result;
      }
    } catch (e) {
      if (context.mounted) error.value = e.toString();
    }
    if (context.mounted) isUpdating.value = false;
  }

  Future<void> pickImage() async {
    if (!context.mounted) return;
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null && context.mounted) {
      selectedImage.value = file.path;
    }
  }

  void logout(void Function() onSuccess) async {
    if (!context.mounted) return;
    isLoggingOut.value = true;
    try {
      await repo.logout();
      await PrefHelper.clearToken();
      if (context.mounted) onSuccess();
    } catch (_) {
      if (context.mounted) onSuccess();
    }
    if (context.mounted) isLoggingOut.value = false;
  }

  useEffect(() {
    Future.microtask(() async {
      final token = await PrefHelper.getToken();
      if (!context.mounted) return;
      final guest = (token == 'guest');
      isGuest.value = guest;
      if (!guest) {
        await fetchUser();
      } else {
        loading.value = false;
      }
    });
    return null;
  }, const []);

  return UseProfileHook(
    user: user.value,
    loading: loading.value,
    error: error.value,
    isUpdating: isUpdating.value,
    isLoggingOut: isLoggingOut.value,
    isGuest: isGuest.value,
    selectedImage: selectedImage.value,
    refresh: fetchUser,
    updateUser: updateUserProfile,
    uploadImage: pickImage,
    logout: logout,
  );
}

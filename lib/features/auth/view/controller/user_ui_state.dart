import 'package:image_picker/image_picker.dart';
import 'package:riverpod/legacy.dart';

final userUiControllerProvider =
    StateNotifierProvider<UserUiController, UserUiState>(
      (ref) => UserUiController(),
    );

class UserUiState {
  final bool showVisa;
  final bool isUpdating;
  final bool isLoggingOut;
  final String? selectedImage;
  const UserUiState({
    this.showVisa = false,
    this.isUpdating = false,
    this.isLoggingOut = false,
    this.selectedImage,
  });

  UserUiState copyWith({
    bool? showVisa,
    bool? isUpdating,
    bool? isLoggingOut,
    String? selectedImage,
  }) {
    return UserUiState(
      showVisa: showVisa ?? this.showVisa,
      isUpdating: isUpdating ?? this.isUpdating,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}

class UserUiController extends StateNotifier<UserUiState> {
  UserUiController() : super(UserUiState());

  void isShowVisa(bool value) {
    state = state.copyWith(showVisa: value);
  }

  void isUpdate(bool value) {
    state = state.copyWith(isUpdating: value);
  }

  void isLogout(bool value) {
    state = state.copyWith(isLoggingOut: value);
  }

  Future<void> uploadImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      state = state.copyWith(selectedImage: pickedImage.path);
    }
  }
}

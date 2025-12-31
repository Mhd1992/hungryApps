import 'package:riverpod/legacy.dart';

final userUiControllerProvider =
    StateNotifierProvider<UserUiController, UserUiState>(
      (ref) => UserUiController(),
    );

class UserUiState {
  final bool showVisa;
  final bool isUpdating;
  final bool isLoggingOut;

  const UserUiState({
    this.showVisa = false,
    this.isUpdating = false,
    this.isLoggingOut = false,
  });

  UserUiState copyWith({bool? showVisa, bool? isUpdating, bool? isLoggingOut}) {
    return UserUiState(
      showVisa: showVisa ?? this.showVisa,
      isUpdating: isUpdating ?? this.isUpdating,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
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
}

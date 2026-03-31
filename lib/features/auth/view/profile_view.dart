import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/features/auth/view/controller/user_ui_state.dart';
import 'package:hungry/update_features/auth/controller/auth_controller.dart';

import '../../../core/utils/exported_file.dart' hide UserModel;
import '../../../shared/custom_load_image_button.dart';
import '../../../update_features/user/data/user_model.dart';
import 'package:hungry/features/settings/views/settings_view.dart';

import '../widgets/visa_card_widget.dart';
import 'controller/user_action_controller.dart';
import 'controller/user_controller.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController visaController = TextEditingController();

  // AuthRepo authRepo = AuthRepo();
  late ProviderSubscription<AsyncValue<UserModel?>> userListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(userControllerProvider.notifier).getProfile();
    });
    userListener = ref.listenManual<AsyncValue<UserModel?>>(
      userControllerProvider,
      (prev, next) {
        next.whenOrNull(
          data: (user) {
            if (user == null) return;

            nameController.text = user.name;
            emailController.text = user.email;
            addressController.text = user.address ?? '';
            ref
                .read(userUiControllerProvider.notifier)
                .isShowVisa(user.visa != null);
          },
        );
      },
    );

    ref.listenManual<AsyncValue<String?>>(userActionControllerProvider, (
      prev,
      next,
    ) {
      next.whenOrNull(
        data: (message) {
          if (message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.orange,

                content: SizedBox(
                  height: 48,
                  child: Center(
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
    });
  }

  @override
  void dispose() {
    userListener.closed;
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    visaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userControllerProvider);
    final uiState = ref.watch(userUiControllerProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: (ref.read(guestProvider.notifier).state)
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                scrolledUnderElevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                actions: [
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingsView()),
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/settings.svg',
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.modulate,
                      ),
                    ),
                  ),
                ],
              ),
              body: GuestLogo(),
            )
          : Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: AppColors.primaryColor,
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                scrolledUnderElevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                actions: [
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingsView()),
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/settings.svg',
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.modulate,
                      ),
                    ),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  ref.read(userControllerProvider.notifier).getProfile();
                  // await getProfileData();
                },

                child: state.when(
                  data: (data) =>
                      buildProfileData(data, uiState.showVisa, uiState),
                  error: (_, _) => Center(child: Text('error')),
                  loading: () =>
                      buildProfileData(null, uiState.showVisa, uiState),
                ),
              ),
              bottomSheet: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => ref
                              .read(userControllerProvider.notifier)
                              .updateUserData(
                                UserModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                  address: addressController.text,
                                  visa: visaController.text,
                                  image: uiState.selectedImage,
                                ),
                              ),
                          child: (uiState.isUpdating)
                              ? CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CustomText(
                                        text: 'Edit Profile',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Gap(8),
                                      SvgPicture.asset('assets/icons/edit.svg'),
                                    ],
                                  ),
                                ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await ref
                                .read(userActionControllerProvider.notifier)
                                .logOut(
                                  onSuccess: () {
                                    Navigator.of(ref.context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => const LoginView(),
                                      ),
                                    );
                                  },
                                );
                          },

                          child: (uiState.isLoggingOut)
                              ? CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppColors.primaryColor,
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CustomText(
                                        text: 'Logout',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Gap(8),
                                      Icon(Icons.logout, color: Colors.white),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildProfileData(UserModel? data, bool showVisa, UserUiState ui) {
    return Skeletonizer(
      enabled: data == null,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      border: Border.all(width: 2, color: Colors.white),
                      image: ui.selectedImage != null
                          ? DecorationImage(
                              image: FileImage(File(ui.selectedImage!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),

                    clipBehavior: Clip.antiAlias,
                    child:
                        (ui.selectedImage == null || ui.selectedImage!.isEmpty)
                        ? (data?.image != null && data!.image!.isNotEmpty)
                              ? Image.network(
                                  data.image!,
                                  errorBuilder: (context, error, builder) =>
                                      Icon(Icons.person),
                                )
                              : Image.asset(
                                  'assets/images/placeHolder.png',
                                  fit: BoxFit.cover,
                                )
                        : Image.file(
                            File(ui.selectedImage!),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Gap(8),
                  CustomLoadImageButton(
                    buttonText: 'Load Image',
                    color: Colors.white,
                    onPressed: ref
                        .read(userUiControllerProvider.notifier)
                        .uploadImage,
                  ),
                  Gap(32),
                  CustomUserTextField(
                    controller: nameController,
                    filed: 'Name',
                  ),
                  Gap(16),
                  CustomUserTextField(
                    controller: emailController,
                    filed: 'Email',
                  ),
                  Gap(16),
                  CustomUserTextField(
                    controller: addressController,
                    filed: 'Address',
                  ),
                  Gap(12),
                  Divider(),
                  Gap(12),
                  (showVisa)
                      ? VisaCardWidget(
                          titleText: 'Debit Card',
                          subTitleText: '•••• •••• •••• 2022',
                        )
                      : CustomUserTextField(
                          controller: visaController,
                          filed: 'XXXX-XXXX-XXXX-0505',
                          type: TextInputType.number,
                        ),
                  Gap(32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

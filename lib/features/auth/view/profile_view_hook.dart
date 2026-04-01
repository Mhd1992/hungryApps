import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_load_image_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_user_text_field.dart';
import '../../../shared/guest_logo.dart';
import '../../../update_features/user/model/user_model.dart';
import '../../settings/views/settings_view.dart';
import '../widgets/visa_card_widget.dart';
import 'hooks/user_hook.dart';
import 'login_view.dart';

class ProfileViewHook extends HookConsumerWidget {
  const ProfileViewHook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final addressController = useTextEditingController();
    final visaController = useTextEditingController();

    final userHook = useProfile(context);

    useEffect(() {
      final data = userHook.user;
      if (data != null) {
        nameController.text = data.name;
        emailController.text = data.email;
        addressController.text = data.address ?? '';
        visaController.text = data.visa ?? '';
      }
      return null;
    }, [userHook.user]);

    if (userHook.isGuest) {
      return GestureDetector(onTap: () {}, child: const GuestLogo());
    }

    if (userHook.loading && userHook.user == null) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    }

    if (userHook.error != null) {
      return Center(child: Text(userHook.error!));
    }

    final data = userHook.user;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          scrolledUnderElevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsView())),
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
          onRefresh: userHook.refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _ProfileAvatar(
                        data: data,
                        selectedImage: userHook.selectedImage,
                      ),
                      const Gap(8),
                      CustomLoadImageButton(
                        buttonText: 'Load Image',
                        color: Colors.white,
                        onPressed: userHook.uploadImage,
                      ),
                      const Gap(32),
                      CustomUserTextField(
                        controller: nameController,
                        filed: 'Name',
                      ),
                      const Gap(16),
                      CustomUserTextField(
                        controller: emailController,
                        filed: 'Email',
                      ),
                      const Gap(16),
                      CustomUserTextField(
                        controller: addressController,
                        filed: 'Address',
                      ),
                      const Gap(12),
                      const Divider(),
                      const Gap(12),
                      (data?.visa != null && data!.visa!.isNotEmpty)
                          ? const VisaCardWidget(
                              titleText: 'Debit Card',
                              subTitleText: '•••• •••• •••• 2022',
                            )
                          : CustomUserTextField(
                              controller: visaController,
                              filed: 'XXXX-XXXX-XXXX-0505',
                              type: TextInputType.number,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: IntrinsicHeight(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (data == null) return;
                      final updatedUser = UserModel(
                        name: nameController.text,
                        email: emailController.text,
                        address: addressController.text,
                        visa: visaController.text,
                        image: userHook.selectedImage,
                      );
                      await userHook.updateUser(updatedUser);
                    },
                    child: userHook.isUpdating
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: 'Edit Profile',
                                  fontWeight: FontWeight.bold,
                                ),
                                const Gap(8),
                                SvgPicture.asset('assets/icons/edit.svg'),
                              ],
                            ),
                          ),
                  ),
                  GestureDetector(
                    onTap: () => userHook.logout(() {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginView()),
                      );
                    }),
                    child: userHook.isLoggingOut
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.primaryColor,
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CustomText(
                                  text: 'Logout',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                const Gap(8),
                                const Icon(Icons.logout, color: Colors.white),
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
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.data, required this.selectedImage});

  final UserModel? data;
  final String? selectedImage;

  @override
  Widget build(BuildContext context) {
    final hasLocalImage = selectedImage != null && selectedImage!.isNotEmpty;
    final hasNetworkImage = data?.image != null && data!.image!.isNotEmpty;

    return Container(
      height: 110,
      width: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
        border: Border.all(width: 2, color: Colors.white),
        image: hasLocalImage
            ? DecorationImage(
                image: FileImage(File(selectedImage!)),
                fit: BoxFit.cover,
              )
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: hasLocalImage
          ? null
          : (hasNetworkImage
                ? Image.network(
                    data!.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.person),
                  )
                : Image.asset(
                    'assets/images/placeHolder.png',
                    fit: BoxFit.cover,
                  )),
    );
  }
}

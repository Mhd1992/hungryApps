import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/exported_file.dart' hide UserModel;
import '../../../shared/custom_load_image_button.dart';
import '../../../update_features/user/data/user_model.dart';
import '../data/repository/v1/auth_repo_v1.dart';
import '../widgets/visa_card_widget.dart';
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

  AuthRepo authRepo = AuthRepo();
  AuthRepoV1 authRepoV1 = AuthRepoV1();
  UserModel? userModel;
  bool showVisa = false;
  bool isUpdating = false;
  bool isLoggingOut = false;
  void Function()? removeListener;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(userControllerProvider.notifier).getProfile();
    });

    ref.listenManual<AsyncValue<UserModel?>>(userControllerProvider, (
      prev,
      next,
    ) {
      next.whenOrNull(
        data: (user) {
          nameController.text = user!.name;
          emailController.text = user.email;
          addressController.text = user.address ?? '';
          showVisa = user.visa != null;
          setState(() {});
        },
      );
    });
  }

  @override
  void dispose() {
    removeListener?.call(); // cleanup listener

    super.dispose();
  }

  Future<void> getProfileData({bool updatedData = false}) async {
    try {
      final user = await authRepoV1.profile(updatedData: updatedData);
      if (user != null) {
        setState(() {
          /*   userModel = user;
          nameController.text = user.name;
          emailController.text = user.email;
          addressController.text = user.address ?? '';
          showVisa = user.visa != null;*/
        });
      }
    } catch (e) {
      String errorMessage = 'unknown Error';
      if (e is ApiError) {
        errorMessage = e.message;
        if (mounted) {
          context.showSnackBar(errorMessage);
        }
      }
    }
  }

  String? selectedImage;

  Future<void> uploadImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  Future<void> updateProfileData() async {
    try {
      setState(() {
        isUpdating = true;
      });

      final user = await authRepoV1.editProfile(
        name: nameController.text,
        email: emailController.text,
        address: addressController.text,
        visa: visaController.text,
        imagePath: selectedImage,
      );
      if (user != null) {
        setState(() {
          //   userModel = user;
          isUpdating = false;
          context.showSnackBar('user updated successfully');
        });
      }
    } catch (e) {
      String errorMessage = 'unknown Error';
      if (e is ApiError) {
        errorMessage = e.message;
        if (mounted) {
          context.showSnackBar(errorMessage);
        }
      }
    } finally {
      setState(() {
        isUpdating = false;
        getProfileData(updatedData: true);
      });
    }
  }

  Future<void> logout() async {
    try {
      setState(() {
        isLoggingOut = true;
      });
      // await authRepo.logout();
      await authRepoV1.logout();

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    } catch (e) {
      String errorMessage = 'unknown Error';
      if (e is ApiError) {
        errorMessage = e.message;
        if (mounted) {
          context.showSnackBar(errorMessage);
        }
      }
    } finally {
      setState(() {
        isLoggingOut = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userControllerProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: (authRepo.isGuest)
          ? GuestLogo()
          : Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: AppColors.primaryColor,
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                scrolledUnderElevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SvgPicture.asset(
                      'assets/icons/settings.svg',
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.modulate,
                      ),
                    ),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  // await getProfileData();
                },

                child: state.when(
                  data: (data) => buildProfileData(data),
                  error: (_, _) => Center(child: Text('error')),
                  loading: () => buildProfileData(null),
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
                                  image: selectedImage,
                                ),
                              ),
                          child: (isUpdating)
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
                            /*    setState(() {
                              isLoggingOut = true;
                            });*/
                            await ref
                                .read(userControllerProvider.notifier)
                                .logout();
                            //   await Future.delayed(const Duration(seconds: 2));
                            if (!context.mounted) return;

                            /*    setState(() {
                              isLoggingOut = false;
                            });*/
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const LoginView(),
                              ),
                            );
                          },

                          child: Container(
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
                                (isLoggingOut)
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : CustomText(
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

  Widget buildProfileData(UserModel? data) {
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
                      image: selectedImage != null
                          ? DecorationImage(
                              image: FileImage(File(selectedImage!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),

                    clipBehavior: Clip.antiAlias,
                    child: (selectedImage == null || selectedImage!.isEmpty)
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
                        : Image.file(File(selectedImage!), fit: BoxFit.cover),
                  ),
                  Gap(8),
                  CustomLoadImageButton(
                    buttonText: 'Load Image',
                    color: Colors.white,
                    onPressed: uploadImage,
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
                      /* DefaultVisa(
                                titleText: 'Debit Card',
                                subTitleText: '3566 **** **** 0505',
                                imageUrl: 'assets/icons/visa.png',
                              )*/
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

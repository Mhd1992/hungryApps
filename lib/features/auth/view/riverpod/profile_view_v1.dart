import 'package:hungry/core/data/base_controller.dart';
import 'package:hungry/core/data/repositories/auth/auth_provider.dart';
import 'package:hungry/core/data/repositories/auth/auth_repo.dart';
import 'package:hungry/core/data/repositories/auth/auth_state.dart';
import 'package:hungry/core/utils/exported_file.dart' hide AuthRepo;
import 'package:hungry/gen/assets.gen.dart';
import 'package:hungry/shared/app_assets/app_assets.dart';

class ProfileViewV1 extends ConsumerStatefulWidget {
  const ProfileViewV1({super.key});

  @override
  ConsumerState<ProfileViewV1> createState() => _ProfileViewV1State();
}

class _ProfileViewV1State extends ConsumerState<ProfileViewV1> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController visaController = TextEditingController();
  void Function()? removeListener;
  AuthRepoV1 authRepoV1 = AuthRepoV1();
  UserModel? userModel;
  bool showVisa = false;

  late final ProviderSubscription<AsyncValue<UserModel?>> _listener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      //ref.read(authProvider).profile(ref: ref);
      final userController = ref.read(authControllerProvider.notifier);
      userController.profile(() => ref.read(authProvider).profile(ref: ref));
      // getProfileData(ref);
    });
    final authRepo = ref.read(authProvider);
    final profileController = BaseController<UserModel>(authRepo);
    //ListenManual because inside initSate can used only ref.listenManual
    _listener = ref.listenManual<AsyncValue<UserModel?>>(authState, (
      prev,
      next,
    ) {
      next.whenOrNull(
        data: (user) {
          if (user == null) return;

          nameController.text = user.name;
          emailController.text = user.email;
          addressController.text = user.address ?? '';
          visaController.text = user.visa ?? '';

          showVisa = user.visa != null;

          if (!mounted) return;
          if (ref.read(updateProfile)) {
            context.showSnackBar("Profile updated");
            ref.read(updateProfile.notifier).state = false;
          }

          setState(() {});
        },
        error: (e, _) {
          if (mounted) {
            context.showSnackBar(e.toString());
          }
        },
      );
    });
  }

  @override
  void dispose() {
    removeListener?.call(); // cleanup listener

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final user = ref.watch(userProvider);

    final userState = ref.watch(authControllerProvider);
    final userController = ref.read(authControllerProvider.notifier);

    final user = ref.watch(authState);

    final loading = ref.watch(loadingState);
    final logOutLoading = ref.watch(logoutLoading);
    final selectedImage = ref.watch(selectedImageProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: (ref.read(authProvider).isGuest(ref))
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
                    padding: const EdgeInsets.all(8.0),
                    child: AppAsset(
                      path: Assets.icons.settings,
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              body: userState.when(
                data: (userData) {
                  return Skeletonizer(
                    enabled: false, // no skeleton when data is ready
                    child: buildProfileBody(userData),
                  );
                },
                loading: () {
                  return Skeletonizer(
                    enabled: true,
                    child: buildProfileBody(
                      null,
                    ), // all empty values become skeleton
                  );
                },
                error: (e, _) => Center(child: Text("Error: $e")),
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
                          onTap: () async {
                            ref.read(authControllerProvider.notifier);
                            userController.updateData(
                              () => ref
                                  .read(authProvider)
                                  .updateProfileInfo(
                                    updateRequest: UserModel(
                                      name: nameController.text,
                                      email: emailController.text,
                                      address: addressController.text,
                                      visa: visaController.text,
                                      image: selectedImage,
                                    ),
                                    ref: ref,
                                  ),
                            );
                            /*       ref
                                .read(authProvider)
                                .updateProfileInfo(
                                  updateRequest: UserModel(
                                    name: nameController.text,
                                    email: emailController.text,
                                    address: addressController.text,
                                    visa: visaController.text,
                                    image: selectedImage,
                                  ),

                                  ref: ref,
                                );*/
                          },
                          child: (loading)
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
                          onTap: () => ref.read(authProvider).logout(ref: ref),
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
                                (logOutLoading)
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

  Widget buildProfileBody(UserModel? userData) {
    return SingleChildScrollView(
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
                    image:
                        ref.read(selectedImageProvider.notifier).state != null
                        ? DecorationImage(
                            image: FileImage(
                              File(
                                ref.read(selectedImageProvider.notifier).state!,
                              ),
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),

                  clipBehavior: Clip.antiAlias,
                  child:
                      (ref.read(selectedImageProvider.notifier).state == null ||
                          ref
                              .read(selectedImageProvider.notifier)
                              .state!
                              .isEmpty)
                      ? (userData?.image != null && userData!.image!.isNotEmpty)
                            ? Image.network(
                                userData.image!,
                                errorBuilder: (context, error, builder) =>
                                    Icon(Icons.person),
                              )
                            : Image.asset(
                                'assets/images/placeHolder.png',
                                fit: BoxFit.cover,
                              )
                      : Image.file(
                          File(ref.read(selectedImageProvider.notifier).state!),
                          fit: BoxFit.cover,
                        ),
                ),
                Gap(8),
                CustomLoadImageButton(
                  buttonText: 'Load Image',
                  color: Colors.white,
                  onPressed: () => uploadImage(ref),
                ),
                Gap(32),
                CustomUserTextField(controller: nameController, filed: 'Name'),
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
    );
  }
}

import 'package:hungry/core/utils/exported_file.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController visaController = TextEditingController();

  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  bool showVisa = false;

  @override
  void initState() {
    // TODO: implement initState

    getProfileData();
    super.initState();
  }

  Future<void> getProfileData() async {
    try {
      print('getting profile data...');
      final user = await authRepo.getProfile();
      if (user != null) {
        setState(() {
          userModel = user;
          nameController.text = user.name;
          emailController.text = user.email;
          addressController.text = user.address ?? '';

          showVisa = user.visa != null;
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

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SvgPicture.asset(
                'assets/icons/settings.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.modulate),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await getProfileData();
          },

          child: Skeletonizer(
            enabled: userModel == null,
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
                          ),
                          clipBehavior: Clip.antiAlias,
                          child:
                              (userModel?.image != null &&
                                  userModel!.image!.isNotEmpty)
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/placeHolder.png',
                                  image: userModel!.image!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/placeHolder.png',
                                  fit: BoxFit.cover,
                                ),
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
                        CustomUserTextField(
                          controller: visaController,
                          filed: 'XXXX-XXXX-XXXX-0505',
                          type: TextInputType.number,
                        ),
                        Gap(12),
                        (showVisa)
                            ? DefaultVisa(
                                titleText: 'Debit Card',
                                subTitleText: '3566 **** **** 0505',
                                imageUrl: 'assets/icons/visa.png',
                              )
                            : SizedBox(),
                        Gap(32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryColor, width: 2),
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
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.primaryColor,
                      border: Border.all(color: Colors.grey.shade400, width: 2),
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
    );
  }
}

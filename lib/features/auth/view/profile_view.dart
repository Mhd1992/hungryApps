import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/checkout/widgets/default_visa.dart';
import 'package:hungry/shared/custom_user_text_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    nameController.text = "Alhammali";
    emailController.text = "Alhammali@name.com";
    addressController.text = "Libya";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 5, color: Colors.white),
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                    size: 128,
                  ),
                ),
              ),
            ),
            Gap(32),
            CustomUserTextField(controller: nameController, filed: 'Name'),
            Gap(16),
            CustomUserTextField(controller: emailController, filed: 'Email'),
            Gap(16),
            CustomUserTextField(
              controller: addressController,
              filed: 'Address',
            ),
            Gap(24),
            Divider(),
            Gap(48),
            DefaultVisa(
              titleText: 'Debit Card',
              subTitleText: '3566 **** **** 0505',
              imageUrl: 'assets/icons/visa.png',
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.primaryColor,
                  border: Border.all(color: Colors.grey.shade400, width: 5),
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
            ],
          ),
        ),
      ),
    );
  }
}

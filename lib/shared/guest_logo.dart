import 'package:hungry/core/utils/exported_file.dart';

class GuestLogo extends StatelessWidget {
  const GuestLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LogoImage(
            color: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
          Gap(32),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.yellow, // border color
                width: 4, // border thickness
              ),
              borderRadius: BorderRadius.circular(20), // rounded corners
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/guestLogo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(8),
          CustomText(
            text: 'You are guest please create an account',
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}

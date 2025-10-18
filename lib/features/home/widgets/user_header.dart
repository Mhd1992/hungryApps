import 'package:hungry/core/utils/exported_file.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(48),
            LogoImage(
              color: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              height: 35,
            ),

            Gap(8),
            CustomText(
              text: 'Hello dear user',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryColor,
          child: Icon(CupertinoIcons.person, color: Colors.white),
        ),
      ],
    );
  }
}

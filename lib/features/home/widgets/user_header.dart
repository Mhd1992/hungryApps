import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/logo_image.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20),
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

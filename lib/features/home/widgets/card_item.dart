import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.rate,
  });

  final String title, imageUrl, description, rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover, width: 180),
            Gap(10),
            CustomText(text: title, fontWeight: FontWeight.bold),
            CustomText(text: description),
            Row(
              children: [
                CustomText(text: '⭐️$rate'),
                Spacer(),
                Icon(CupertinoIcons.heart_fill, color: AppColors.primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

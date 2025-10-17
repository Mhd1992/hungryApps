import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Customize Your Burger to Your Tastes. Ultimate Experience',
            fontWeight: FontWeight.w500,
          ),
          Gap(16),
          CustomText(
            text: 'Spicy Level',
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
          Gap(16),
          Slider(
            padding: EdgeInsets.zero,
            min: 0,
            max: 1,
            value: value,
            activeColor: AppColors.primaryColor,
            inactiveColor: Colors.grey,
            onChanged: onChanged,
          ),
          Row(children: [Text('🥶'), Spacer(), Text('🌶️')]),
        ],
      ),
    );
  }
}

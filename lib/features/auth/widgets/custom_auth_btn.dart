import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CustomAuthBtn extends StatelessWidget {
  const CustomAuthBtn({super.key, this.onPressed, required this.text});

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white, // Background color
        elevation: 0, // No shadow
      ),
      child: Center(
        child: CustomText(
          text: text,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );
  }
}

/***
 *
 *     above is equavelent to below
    GestureDetector(
    child: Container(
    height: 48,
    width: double.infinity,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    ),
    child: Center(
    child: CustomText(
    text: 'Login',
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w800,
    fontSize: 16,
    ),
    ),
    ),
    ),
 *
 *
 */

import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CustomAuthBtn extends StatelessWidget {
  const CustomAuthBtn({
    super.key,
    this.onPressed,
    required this.text,
    this.color,
    this.textColor,
  });

  final Function()? onPressed;
  final String text;
  final Color? color, textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: color ?? Colors.white, // Button background
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: const [
            BoxShadow(
              color:
                  Colors.transparent, // No elevation (same as ElevatedButton)
              blurRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: CustomText(
          text: text,
          color: textColor ?? AppColors.primaryColor,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );
  }
}

import 'package:hungry/core/utils/exported_file.dart';

void showCustomSnackBar(
  BuildContext context, {
  required String message,
  IconData icon = CupertinoIcons.info,
  Color? backgroundColor,
  Color? textColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor ?? Colors.yellow.shade700,
      content: Row(
        children: [
          Icon(icon, color: textColor ?? AppColors.primaryColor),
          const Gap(8),
          Expanded(
            child: CustomText(
              text: message,
              color: textColor ?? AppColors.primaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:hungry/core/utils/exported_file.dart';

extension ContextExtensions on BuildContext {
  // Custom Snackbar
  void showSnackBar(
    String message, {
    IconData icon = CupertinoIcons.info,
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
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

  // Custom AlertDialog
  Future<void> showAlertDialog({
    required String title,
    required String content,
    String confirmText = "OK",
    VoidCallback? onConfirm,
    bool isDismissible = true,
  }) async {
    return showDialog(
      context: this,
      barrierDismissible: isDismissible,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) onConfirm();
              },
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}

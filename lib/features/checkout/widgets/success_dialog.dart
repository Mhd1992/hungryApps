import 'package:hungry/core/utils/exported_file.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            child: Icon(
              Icons.check_circle,
              color: AppColors.primaryColor,
              size: 60,
            ),
          ),
          Gap(20),
          const CustomText(
            text: 'Payment Successful!',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const Gap(10),
          const CustomText(
            text: 'Thank you for your purchase.',
            fontSize: 14,
            color: Colors.grey,
          ),
          const Gap(20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 12.0,
              ),
            ),
            child: const CustomText(
              text: 'Continue Shopping',
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

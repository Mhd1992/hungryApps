import 'package:hungry/core/utils/exported_file.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.hintText = true,
  });
  final double value;
  final ValueChanged<double>? onChanged;
  final bool hintText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (hintText)
              ? CustomText(
                  text:
                      ' Customize Your Burger to Your Tastes. Ultimate Experience',
                  fontWeight: FontWeight.w500,
                )
              : SizedBox(),
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
